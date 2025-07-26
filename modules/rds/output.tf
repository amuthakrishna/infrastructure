output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_security_group_id" {
  description = "Security group ID of RDS instance"
  value       = aws_security_group.rds.id
}