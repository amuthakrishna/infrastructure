variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}



variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}