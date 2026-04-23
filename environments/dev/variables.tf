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

# -----------------------------------------------------------------------------
# Network
# -----------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
}

variable "azs" {
  description = "Availability Zones the VPC spans."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets, one per AZ."
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets, one per AZ."
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets, one per AZ."
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Use a single shared NAT gateway instead of one per AZ. Cheaper, less available."
  type        = bool
  default     = false
}
