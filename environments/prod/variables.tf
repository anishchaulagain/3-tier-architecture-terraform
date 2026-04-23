variable "aws_region" {
  description = "AWS region for this environment."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
}

variable "project_name" {
  description = "Project identifier used in resource names and tags."
  type        = string
}

variable "owner" {
  description = "Team or individual accountable for this environment."
  type        = string
}
