# Terraform Module: terraform-aws-remote-state

**Note**: Instead of managing Terraform state yourself, use Terraform Cloud. See [here](https://www.terraform.io/docs/cloud/getting-started/access.html) to get started.

This Terraform module provisions a S3 bucket for remote state storage and a DynamoDB table for state locking.

The S3 bucket is created with versioning, server-side encryption, and logging enabled. A custom KMS encryption key is provisioned to encrypt objects stored in the S3 bucket. Bucket access logs are sent to a seperate S3 bucket.

2 IAM Groups are created allowing varying levels of access to the S3 bucket:

| Group | Description
| -------- | --------
| terraform_rw_access | allows full access to the S3 bucket and read/write access to the DynamoDB table
| terraform_ro_access | allows read-only access to the S3 bucket and read/write access to the DynamoDB table

The ARNs of the IAM Policies attached to these IAM Groups are exported to allow use elsewhere such as with IAM Roles.


## Prerequisites

Terraform version 0.12.0 or newer is required.


### Usage

Use the module in Terraform code:

    module "remote_state_setup" {
      source = "git::https://github.com/bincyber/terraform-aws-remote-state"

      aws_region          = "us-east-1"
      aws_environment     = "Prod"
      s3_bucket_name      = "terraform-remote-state"
      dynamodb_table_name = "terraform-state-locking"
    }


## Module Variables

A brief description of the variables used in this module:

| Variable | Type | Explanation
| -------- | -------- | --------
| aws_region | String | the AWS region to use (eg, us-west-2)
| aws_environment | String | the name of the AWS environment (eg. Prod/Staging/Dev/Test)
| s3_bucket_name | String | the name of the S3 bucket which will be used to store state files
| dynamodb_table_name | String | the name of the DynamoDB table which will be used for state locking
| dynamodb_read_capacity_units | Integer | the amount of read capacity units for the DynamoDB table
| dynamodb_write_capacity_units | Integer | the amount of write capacity units for the DynamoDB table
| iam_group_name_rw_access | String | the name of the IAM group that will have read-write access
| iam_group_name_ro_access | String | the name of the IAM group that will have read-only access


## Exported Attributes

See `outputs.tf` for exported module attributes.
