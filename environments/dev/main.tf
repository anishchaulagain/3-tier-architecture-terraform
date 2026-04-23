# Dev environment — composes shared modules into a full 3-tier stack.
# Each module is intentionally called with no inputs here; wire them up as
# the modules gain their variable surface.

locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "vpc" {
  source = "../../modules/vpc"

  name                     = local.name_prefix
  vpc_cidr                 = var.vpc_cidr
  azs                      = var.azs
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  single_nat_gateway       = var.single_nat_gateway
}

module "security_groups" {
  source = "../../modules/security-groups"
}

module "alb" {
  source = "../../modules/alb"
}

module "web_tier" {
  source = "../../modules/web-tier"
}

module "app_tier" {
  source = "../../modules/app-tier"
}

module "db_tier" {
  source = "../../modules/db-tier"
}

module "bastion" {
  source = "../../modules/bastion"
}
