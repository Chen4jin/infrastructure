# ---------------------------------------------------------------------------
# CloudFront distribution (CDN)
# ---------------------------------------------------------------------------

resource "aws_cloudfront_distribution" "cdn" {
  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = true
    target_origin_id       = local.s3_domain_photos
    viewer_protocol_policy = "redirect-to-https"

    grpc_config {
      enabled = false
    }
  }

  ordered_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    path_pattern           = "/static/*"
    target_origin_id       = local.s3_domain_static
    viewer_protocol_policy = "redirect-to-https"

    grpc_config {
      enabled = false
    }
  }

  origin {
    domain_name              = local.s3_domain_static
    origin_id                = local.s3_domain_static
    origin_access_control_id = "EX1I8MQPE0EDZ"
    connection_attempts      = 3
    connection_timeout       = 10
  }

  origin {
    domain_name              = local.s3_domain_photos
    origin_id                = local.s3_domain_photos
    origin_access_control_id = "E1DPE5I8P3DVDA"
    connection_attempts      = 3
    connection_timeout       = 10
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version      = "TLSv1"
  }
}
