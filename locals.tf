locals {
  region = var.aws_region

  # S3 bucket names (single source of truth for CloudFront origins)
  s3_bucket_static = "generic-jin"
  s3_bucket_photos = "photos-jin"

  # S3 domain names for CloudFront origins (region-specific)
  s3_domain_static = "${local.s3_bucket_static}.s3.${local.region}.amazonaws.com"
  s3_domain_photos = "${local.s3_bucket_photos}.s3.${local.region}.amazonaws.com"

  # Optional: add common tags for resource tagging
  # common_tags = { Project = "infrastructure", ManagedBy = "terraform" }
}
