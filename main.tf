# Terraform - AWS
# https://www.terraform.io/docs/providers/aws/index.html
# https://www.terraform.io/docs/configuration/interpolation.html
# https://www.terraform.io/docs/configuration/resources.html
# https://www.terraform.io/docs/configuration/terraform.html#specifying-required-provider-versions

terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = ">= 2.40.0"
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  s3_iam_policy_prefix       = "s3-bucket-${var.s3_bucket_name}"
  dynamodb_iam_policy_prefix = "dynamodb-${var.dynamodb_table_name}"
}
