variable "aws_region" {
  description = "AWS region for the remote-state resources."
  type        = string
}

variable "project_name" {
  description = "Project identifier used as a prefix for bucket and table names."
  type        = string
}

variable "account_id" {
  description = "AWS account ID, appended to the state bucket name to keep it globally unique."
  type        = string
}
