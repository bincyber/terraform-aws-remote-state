# Outputs
# https://www.terraform.io/docs/configuration/outputs.html

output "region" {
  value = var.aws_region
}

output "environment" {
  value = var.aws_environment
}

output "remote_state_bucket_name" {
  value = aws_s3_bucket.remote_state_bucket.id
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote_state_bucket.arn
}

output "logs_bucket_name" {
  value = aws_s3_bucket.logs_bucket.id
}

output "logs_bucket_arn" {
  value = aws_s3_bucket.logs_bucket.arn
}

output "kms_encryption_key_arn" {
  value = aws_kms_key.encryption_key.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.state_locking_table.id
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.state_locking_table.arn
}

output "iam_group_terraform_rw_access_name" {
  value = aws_iam_group.terraform_rw_access.name
}

output "iam_group_terraform_rw_access_arn" {
  value = aws_iam_group.terraform_rw_access.arn
}

output "iam_group_terraform_ro_access_name" {
  value = aws_iam_group.terraform_ro_access.name
}

output "iam_group_terraform_ro_access_arn" {
  value = aws_iam_group.terraform_ro_access.arn
}

output "iam_policy_s3_bucket_rw_access_arn" {
  value = aws_iam_policy.s3_bucket_rw_access.arn
}

output "iam_policy_s3_bucket_ro_access_arn" {
  value = aws_iam_policy.s3_bucket_ro_access.arn
}

output "iam_policy_dynamodb_table_access_arn" {
  value = aws_iam_policy.dynamodb_table_access.arn
}
