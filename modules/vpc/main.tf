# VPC module — network foundation.
# Responsibilities:
#   - VPC with custom CIDR
#   - Public subnets (ALB, NAT, bastion) across AZs
#   - Private app subnets across AZs (no direct internet ingress)
#   - Private DB subnets across AZs (no internet egress)
#   - Internet Gateway, NAT Gateway(s), and route tables
#   - VPC flow logs
