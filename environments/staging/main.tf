# Staging environment — production-like shape, smaller scale.

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
