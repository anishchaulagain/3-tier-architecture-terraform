# Remote state. Values are provided via -backend-config at init time or a
# backend.hcl file, so the same config works across environments.
#
# Example:
#   terraform init \
#     -backend-config="bucket=three-tier-tfstate-us-east-1-000000000000" \
#     -backend-config="dynamodb_table=three-tier-tfstate-lock" \
#     -backend-config="key=envs/dev/terraform.tfstate" \
#     -backend-config="region=us-east-1"

terraform {
  backend "s3" {
    key     = "envs/dev/terraform.tfstate"
    encrypt = true
  }
}
