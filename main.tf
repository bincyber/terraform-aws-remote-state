# Terraform - AWS
# https://www.terraform.io/docs/providers/aws/index.html
# https://www.terraform.io/docs/configuration/interpolation.html
# https://www.terraform.io/docs/configuration/resources.html

terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  region = "${var.aws_region}"
}
