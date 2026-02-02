# ---------------------------------------------------------------------------
# ACM certificates
# ---------------------------------------------------------------------------

resource "aws_acm_certificate" "root_domain" {
  domain_name       = "chenjq.com"
  validation_method = "DNS"
}

resource "aws_acm_certificate" "backend_subdomain_1" {
  domain_name       = "backend.chenjq.com"
  validation_method = "DNS"
}

resource "aws_acm_certificate" "api_subdomain" {
  domain_name       = "api.chenjq.com"
  validation_method = "DNS"

  lifecycle {
    ignore_changes = [validation_method]
  }
}
