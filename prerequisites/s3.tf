resource "aws_s3_bucket" "state" {
  bucket = var.state_bucket
  acl    = "private"
}

resource "aws_s3_bucket" "import" {
  bucket = var.import_bucket
  acl    = "private"
}
