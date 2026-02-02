# ---------------------------------------------------------------------------
# IAM roles and instance profiles
# ---------------------------------------------------------------------------

resource "aws_iam_role" "backend" {
  name                = "backend-user"
  description         = "Allows EC2 instances to call AWS services on your behalf."
  assume_role_policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })

  lifecycle {
    ignore_changes = [inline_policy]
  }
}

resource "aws_iam_instance_profile" "backend" {
  role = aws_iam_role.backend.name
}
