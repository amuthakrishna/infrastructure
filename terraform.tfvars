# infrastructure/terraform.tfvars

db_password = "krishnamoorthy123"

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