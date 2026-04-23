# App tier — internal Auto Scaling Group fronted by an internal ALB/NLB.
# Responsibilities:
#   - Internal load balancer in private subnets (app_sg ingress from web_sg)
#   - Launch template + ASG for application instances
#   - Scaling policies and health checks
#   - Instance IAM role (SSM, app-specific permissions)
#   - Encrypted root volume, IMDSv2 required
