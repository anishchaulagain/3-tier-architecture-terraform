# Web tier — Auto Scaling Group behind the ALB.
# Responsibilities:
#   - Launch template (AMI, instance type, IMDSv2 required, user_data)
#   - ASG across private subnets, registered with the ALB target group
#   - Scaling policies (target-tracking on CPU / ALB request count)
#   - Instance IAM role with SSM + CloudWatch Agent permissions
#   - Root volume encrypted by default
