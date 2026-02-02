# ---------------------------------------------------------------------------
# DynamoDB tables
# ---------------------------------------------------------------------------

resource "aws_dynamodb_table" "photo" {
  name         = "tbl_photo"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "imageID"

  attribute {
    name = "imageID"
    type = "S"
  }

  lifecycle {
    ignore_changes = [point_in_time_recovery, ttl]
  }
}

resource "aws_dynamodb_table" "profile" {
  name         = "tbl_profile"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "profileId"

  attribute {
    name = "profileId"
    type = "S"
  }

  lifecycle {
    ignore_changes = [point_in_time_recovery, ttl]
  }
}
