output "state_bucket_name" {
  description = "S3 bucket that stores Terraform remote state."
  value       = aws_s3_bucket.tfstate.id
}

output "state_lock_table_name" {
  description = "DynamoDB table used for Terraform state locking."
  value       = aws_dynamodb_table.tfstate_lock.name
}
