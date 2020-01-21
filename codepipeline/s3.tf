resource "aws_s3_bucket" "releases" {
  bucket = var.codepipeline_bucket_name                   
  acl    = "private"
  
  versioning {
    enabled = true
  }
}
