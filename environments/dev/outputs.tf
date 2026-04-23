# Surface the most useful module outputs at the environment level so
# `terraform output` gives operators a quick summary.
# Add outputs here once modules expose them, e.g.:
#   output "alb_dns_name" { value = module.alb.alb_dns_name }
#   output "db_endpoint"  { value = module.db_tier.db_endpoint sensitive = true }
