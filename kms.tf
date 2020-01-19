# KMS
# https://www.terraform.io/docs/providers/aws/r/kms_key.html
# https://www.terraform.io/docs/providers/aws/r/kms_alias.html

resource "aws_kms_key" "encryption_key" {
  description             = "KMS key used to encrypt objects in the S3 Bucket: ${var.s3_bucket_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "encryption_key" {
  name          = "alias/${var.s3_bucket_name}-encryption-key"
  target_key_id = aws_kms_key.encryption_key.key_id
}
