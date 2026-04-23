terraform {
  backend "s3" {
    key     = "envs/prod/terraform.tfstate"
    encrypt = true
  }
}
