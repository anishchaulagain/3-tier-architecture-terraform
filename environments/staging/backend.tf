terraform {
  backend "s3" {
    key     = "envs/staging/terraform.tfstate"
    encrypt = true
  }
}
