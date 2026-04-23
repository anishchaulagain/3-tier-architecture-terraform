# Production environment — full HA, multi-AZ, deletion protection on,
# stricter scaling floors, and tighter ingress allow-lists.

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
