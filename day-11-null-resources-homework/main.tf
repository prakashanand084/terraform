# Create key pair
resource "aws_key_pair" "example" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# IAM Policy to Allow S3 Access
resource "aws_iam_policy" "s3_access_policy" {
  name        = "EC2S3AccessPolicy"
  description = "Policy for EC2 instances to upload logs to S3"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:PutObject", "s3:GetObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::prakash-anand-bucket",
          "arn:aws:s3:::prakash-anand-bucket/*"
        ]
      }
    ]
  })
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "ec2_role_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Create instance profile for role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_s3_access_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# Launch EC2 Instance
resource "aws_instance" "nginx_server" {
  ami                  = "ami-085ad6ae776d8f09c"
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.example.key_name
  security_groups      = ["default"]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  availability_zone    = "us-east-1a"

  tags = {
    Name = "NginxServer"
  }
}

# Install Nginx and Upload Logs to S3
resource "null_resource" "setup_and_upload_logs" {
  depends_on = [aws_instance.nginx_server]

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo 'Welcome to Nginx Server' | sudo tee /usr/share/nginx/html/index.html",
      "sudo touch /var/log/nginx/access.log",
      "aws s3 cp /var/log/nginx/access.log s3://prakash-anand-bucket/"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.nginx_server.public_ip
  }

  triggers = {
    instance_id = aws_instance.nginx_server.id
  }
}
