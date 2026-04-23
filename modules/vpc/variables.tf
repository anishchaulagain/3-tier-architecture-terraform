variable "name" {
  description = "Name prefix applied to VPC resources and tags."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "azs" {
  description = "Availability Zones the VPC spans. Subnet CIDR lists must match this order and length."
  type        = list(string)

  validation {
    condition     = length(var.azs) >= 2
    error_message = "At least two Availability Zones are required for HA."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets — one per AZ, same order as azs."
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets — one per AZ, same order as azs."
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets — one per AZ, same order as azs."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Provision NAT gateways so private-app subnets can reach the internet."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Share a single NAT gateway across all AZs instead of one per AZ. Cheaper, but a zone outage takes egress with it."
  type        = bool
  default     = false
}

variable "enable_flow_logs" {
  description = "Enable VPC flow logs to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Retention for the flow logs CloudWatch log group, in days."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Additional tags merged onto every resource."
  type        = map(string)
  default     = {}
}
