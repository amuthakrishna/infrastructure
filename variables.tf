# infrastructure/variables.tf

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "rails-app"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "railsapp"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "ecs_task_cpu" {
  description = "ECS task CPU units"
  type        = string
  default     = "512"
}

variable "ecs_task_memory" {
  description = "ECS task memory"
  type        = string
  default     = "2048"
}

variable "ecs_service_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

variable "env_s3_key" {
  description = "Key name for the environment file in S3"
  type        = string
  default     = "rails_app.env"
}



variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "RailsApp"
    Environment = "Production"
    Terraform   = "true"
  }
}

variable "container_image_app" {
  description = "ECR image URI for Rails app"
  type        = string
#  default     = "413745378153.dkr.ecr.ap-south-1.amazonaws.com/rails-app-rails-app:latest"
}

variable "container_image_nginx" {
  description = "ECR image URI for Nginx"
  type        = string
#  default     = "413745378153.dkr.ecr.ap-south-1.amazonaws.com/rails-app-nginx:v2"
}