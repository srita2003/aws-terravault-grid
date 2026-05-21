output "state_bucket" {
  value = aws_s3_bucket.terravault_state.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.terravault_lock.name
}