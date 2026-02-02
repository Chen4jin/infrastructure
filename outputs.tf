# ---------------------------------------------------------------------------
# Output values
# ---------------------------------------------------------------------------

output "vpc_id" {
  description = "Primary VPC ID"
  value       = aws_vpc.primary.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets (by AZ: a, b, c, d, e, f)"
  value = {
    az_a = aws_subnet.public_az_a.id
    az_b = aws_subnet.public_az_b.id
    az_c = aws_subnet.public_az_c.id
    az_d = aws_subnet.public_az_d.id
    az_e = aws_subnet.public_az_e.id
    az_f = aws_subnet.public_az_f.id
  }
}

output "public_subnet_ids_list" {
  description = "Public subnet IDs as a list (for modules expecting a list)"
  value       = [for s in [aws_subnet.public_az_a, aws_subnet.public_az_b, aws_subnet.public_az_c, aws_subnet.public_az_d, aws_subnet.public_az_e, aws_subnet.public_az_f] : s.id]
}

output "s3_bucket_static" {
  description = "Static assets S3 bucket name (generic)"
  value       = aws_s3_bucket.static.id
}

output "s3_bucket_photos" {
  description = "Photos S3 bucket name"
  value       = aws_s3_bucket.photos.id
}

output "cloudfront_distribution_id" {
  description = "CloudFront CDN distribution ID"
  value       = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_domain_name" {
  description = "CloudFront CDN domain name"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "dynamodb_table_photo" {
  description = "Photo DynamoDB table name"
  value       = aws_dynamodb_table.photo.name
}

output "dynamodb_table_profile" {
  description = "Profile DynamoDB table name"
  value       = aws_dynamodb_table.profile.name
}

output "ec2_instance_backend_id" {
  description = "Backend EC2 instance ID"
  value       = aws_instance.backend.id
}

output "iam_role_backend_name" {
  description = "Backend IAM role name"
  value       = aws_iam_role.backend.name
}
