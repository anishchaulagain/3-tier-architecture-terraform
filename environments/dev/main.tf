# Dev environment — composes shared modules into a full 3-tier stack.
# Each module is intentionally called with no inputs here; wire them up as
# the modules gain their variable surface.

module "vpc" {
  source = "../../modules/vpc"
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
