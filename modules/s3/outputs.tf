output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.app_storage.bucket
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.app_storage.arn
}

output "env_file_s3_arn" {
  description = "ARN of the environment file in S3"
  value       = "arn:aws:s3:::${aws_s3_bucket.app_storage.bucket}/${var.env_s3_key}"
}

output "env_file_s3_path" {
  description = "S3 bucket/key path of the environment file"
  value       = "${aws_s3_bucket.app_storage.bucket}/${var.env_s3_key}"
}