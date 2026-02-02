# AWS provider configuration.
# Credentials: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN (optional)
# Region: AWS_REGION or set via var.aws_region / terraform.tfvars
provider "aws" {
  region = var.aws_region
}
