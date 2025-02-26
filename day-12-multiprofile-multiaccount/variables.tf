variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile to use for authentication."
  type        = string
  default     = "sonu" # Replace with your profile name if not using the default profile
}


#aws iam list-attached-user-policies --user-name sonu
#aws iam attach-user-policy --user-name sonu --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
# here sonu is IAM user for my side. we can take other user and attached that user by access key and secret key
# aws configure --profile test-user
#aws configure list-profiles