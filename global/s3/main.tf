provider "aws" {
  region = var.region
}

#Create the bucket
resource "aws_s3_bucket" "backend-bucket" {
  bucket = "tf-state-phardy"

  #lifecycle {
   # prevent_destroy = true
  #}
}

#Enabling versioning on the bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.backend-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Enabling server-side encryption on the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.backend-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

#Block public access on S3 bucket
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.backend-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#Create DynamoDB state locking table
resource "aws_dynamodb_table" "tf-locking-table" {
  hash_key = "LockID"
  name     = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}


