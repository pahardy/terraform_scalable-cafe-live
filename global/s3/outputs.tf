output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.backend-bucket.arn
}

output "dynamo_db_table_name" {
  value = aws_dynamodb_table.tf-locking-table.name
}