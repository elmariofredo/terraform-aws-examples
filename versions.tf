terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_providers {
    aws-sso-scim = {
      source = "BurdaForward/aws-sso-scim"
      version = "0.3.1"
    }
  }
}
