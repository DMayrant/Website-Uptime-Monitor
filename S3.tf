resource "aws_s3_bucket" "website_log_bucket" {
  bucket = "website-logs-${random_string.random.result}" 

  tags = merge(local.common_tags, {
    Name = "S3 Bucket logs"
  })
}

resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {
  bucket = aws_s3_bucket.website_log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "random_string" "random" {
  length  = 10
  special = false
  upper   = false
  lower   = true
  numeric = true
}