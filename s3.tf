provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"

}
