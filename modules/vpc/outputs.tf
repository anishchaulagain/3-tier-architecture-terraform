output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "IPv4 CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets, ordered to match var.azs."
  value       = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets, ordered to match var.azs."
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "IDs of the private database subnets, ordered to match var.azs."
  value       = aws_subnet.private_db[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "IDs of the NAT gateways (empty when NAT is disabled)."
  value       = aws_nat_gateway.this[*].id
}

output "public_route_table_id" {
  description = "ID of the shared public route table."
  value       = aws_route_table.public.id
}

output "private_app_route_table_ids" {
  description = "IDs of the per-AZ private-app route tables."
  value       = aws_route_table.private_app[*].id
}

output "private_db_route_table_id" {
  description = "ID of the shared private-db route table."
  value       = aws_route_table.private_db.id
}
