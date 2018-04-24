# IAM Policies
# https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html

/*
Policy for read-write access:
- allows read/write access to the S3 bucket
- allows full access to the created KMS key
*/
data "aws_iam_policy_document" "s3_bucket_rw_access" {
  statement {
    sid    = "TerraformBucketRWAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }

  statement {
    sid    = "2"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }

  statement {
    sid    = "3"
    effect = "Allow"

    actions = [
      "kms:*",
    ]

    resources = [
      "${aws_kms_key.encryption_key.arn}",
    ]
  }
}

/*
Policy for read-only access:
- allows read-only access to the S3 bucket
- allows limited access to the created KMS key
*/
data "aws_iam_policy_document" "s3_bucket_ro_access" {
  statement {
    sid    = "TerraformBucketROAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }

  statement {
    sid    = "2"
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }

  statement {
    sid    = "4"
    effect = "Allow"

    actions = [
      "kms:ListKeys",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid    = "5"
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]

    resources = [
      "${aws_kms_key.encryption_key.arn}",
    ]
  }
}

/*
Policy for the DynamoDB table:
- allows read/write access for all Terraform users
*/
data "aws_iam_policy_document" "dynamodb_table" {
  statement {
    sid    = "AllowRWDynamoDBTable"
    effect = "Allow"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
    ]

    resources = [
      "arn:aws:dynamodb:${var.aws_region}::table/${var.dynamodb_table_name}",
    ]
  }
}
