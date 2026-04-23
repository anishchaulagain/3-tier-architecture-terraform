# Internet-facing Application Load Balancer for the web tier.
# Responsibilities:
#   - ALB in public subnets, attached to alb_sg
#   - HTTPS listener (ACM cert) with HTTP→HTTPS redirect
#   - Target group for the web tier with health checks
#   - Access logs to an S3 bucket
#   - WAF association (optional) and deletion_protection in prod
