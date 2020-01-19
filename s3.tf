# S3
# https://www.terraform.io/docs/providers/aws/r/s3_bucket.html

resource "aws_s3_bucket" "logs_bucket" {
  bucket        = "${var.s3_bucket_name}-logs"
  acl           = "log-delivery-write"
  force_destroy = true
}

resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  /*
    Note:
    Currently Terraform will not force destroy a bucket if it contains versioned files.
    All versions will have to be deleted manually first (ie. empty the bucket).
  */
  force_destroy = false

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.encryption_key.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.logs_bucket.id
    target_prefix = "logs/"
  }

  tags = {
    Name      = "Terraform Remote State bucket"
    Env       = var.aws_environment
    Comment   = "used to store Terraform state files"
    Terraform = "True"
  }
}

