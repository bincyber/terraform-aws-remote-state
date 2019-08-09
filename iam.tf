# IAM config
# https://www.terraform.io/docs/providers/aws/r/iam_policy.html
# https://www.terraform.io/docs/providers/aws/r/iam_group.html
# https://www.terraform.io/docs/providers/aws/r/iam_group_policy_attachment.html

# ---------------------------------------------------------------------------
# IAM Policies
# ---------------------------------------------------------------------------

resource "aws_iam_policy" "s3_bucket_rw_access" {
  name        = "s3-${var.s3_bucket_name}-rw-access"
  description = "Grants read-write access to the S3 Bucket: ${var.s3_bucket_name}"
  policy      = data.aws_iam_policy_document.s3_bucket_rw_access.json
}

resource "aws_iam_policy" "s3_bucket_ro_access" {
  name        = "s3-${var.s3_bucket_name}-ro-access"
  description = "Grants read-only access to the S3 Bucket: ${var.s3_bucket_name}"
  policy      = data.aws_iam_policy_document.s3_bucket_ro_access.json
}

resource "aws_iam_policy" "dynamodb_table_access" {
  name        = "dynamodb-${var.dynamodb_table_name}-access"
  description = "Grants read/write access to the DynamoDB table: ${var.dynamodb_table_name}"
  policy      = data.aws_iam_policy_document.dynamodb_table.json
}

# ---------------------------------------------------------------------------
# IAM Groups
# ---------------------------------------------------------------------------

resource "aws_iam_group" "terraform_rw_access" {
  name = var.iam_group_name_rw_access
}

resource "aws_iam_group" "terraform_ro_access" {
  name = var.iam_group_name_ro_access
}

resource "aws_iam_group_policy_attachment" "terraform_rw_s3_policy" {
  group      = aws_iam_group.terraform_rw_access.name
  policy_arn = aws_iam_policy.s3_bucket_rw_access.arn
}

resource "aws_iam_group_policy_attachment" "terraform_ro_s3_policy" {
  group      = aws_iam_group.terraform_ro_access.name
  policy_arn = aws_iam_policy.s3_bucket_ro_access.arn
}

resource "aws_iam_group_policy_attachment" "terraform_rw_access_dynamodb_policy" {
  group      = aws_iam_group.terraform_rw_access.name
  policy_arn = aws_iam_policy.dynamodb_table_access.arn
}

resource "aws_iam_group_policy_attachment" "terraform_ro_access_dynamodb_policy" {
  group      = aws_iam_group.terraform_ro_access.name
  policy_arn = aws_iam_policy.dynamodb_table_access.arn
}

