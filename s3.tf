# ---------------------------------------------------------------------------
# S3 buckets
# ---------------------------------------------------------------------------

resource "aws_s3_bucket" "static" {
  bucket = local.s3_bucket_static
}

resource "aws_s3_bucket" "photos" {
  bucket = local.s3_bucket_photos
}
