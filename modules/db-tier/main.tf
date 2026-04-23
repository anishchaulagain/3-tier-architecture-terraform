# DB tier — managed relational database.
# Responsibilities:
#   - DB subnet group across private DB subnets
#   - RDS / Aurora cluster with encryption at rest (KMS)
#   - Multi-AZ for staging/prod, single instance for dev
#   - Automated backups, deletion protection in prod
#   - Credentials sourced from Secrets Manager (not hardcoded)
#   - Enhanced monitoring + performance insights
#   - Parameter + option groups
