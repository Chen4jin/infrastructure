# ---------------------------------------------------------------------------
# EC2 instances, EBS volumes, key pairs
# ---------------------------------------------------------------------------

resource "aws_instance" "backend" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"

  lifecycle {
    ignore_changes = [tags, tags_all, user_data, user_data_base64]
  }
}

resource "aws_ebs_volume" "backend_data" {
  availability_zone = "${local.region}a"
  size              = 10
}

resource "aws_key_pair" "local_ssh" {
  key_name   = "local_ssh"
  public_key = "placeholder"

  lifecycle {
    ignore_changes = [public_key]
  }
}

resource "aws_key_pair" "cicd" {
  key_name   = "CI/CD"
  public_key = "placeholder"

  lifecycle {
    ignore_changes = [public_key]
  }
}
