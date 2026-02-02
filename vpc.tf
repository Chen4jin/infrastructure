# ---------------------------------------------------------------------------
# VPC and networking
# ---------------------------------------------------------------------------

resource "aws_vpc" "primary" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_subnet" "public_az_a" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.31.16.0/20"
  availability_zone       = "${local.region}a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_az_b" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.31.32.0/20"
  availability_zone       = "${local.region}b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_az_c" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.31.0.0/20"
  availability_zone       = "${local.region}c"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_az_d" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.31.80.0/20"
  availability_zone       = "${local.region}d"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_az_e" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.31.48.0/20"
  availability_zone       = "${local.region}e"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_az_f" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "172.31.64.0/20"
  availability_zone       = "${local.region}f"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
}

resource "aws_security_group" "backend" {
  name        = "launch-wizard-1"
  description = "launch-wizard-1 created 2025-06-20T20:30:04.368Z"
  vpc_id      = aws_vpc.primary.id

  lifecycle {
    ignore_changes = [egress, ingress]
  }
}

resource "aws_security_group" "default" {
  name        = "default"
  description = "default VPC security group"
  vpc_id      = aws_vpc.primary.id

  lifecycle {
    ignore_changes = [egress, ingress]
  }
}
