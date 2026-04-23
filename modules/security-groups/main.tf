# Security groups module — tier-to-tier traffic boundaries.
# Typical set:
#   - alb_sg      : ingress 80/443 from internet
#   - web_sg      : ingress from alb_sg only
#   - app_sg      : ingress from web_sg only
#   - db_sg       : ingress from app_sg on the DB port only
#   - bastion_sg  : ingress 22 from an allow-list of admin CIDRs
# Prefer source_security_group_id references over CIDRs for east-west rules.
