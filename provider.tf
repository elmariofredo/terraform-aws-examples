# Configure the AWS Provider
provider "aws" {
  region     = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws-sso-scim" {
  # See https://docs.aws.amazon.com/singlesignon/latest/userguide/provision-automatically.html#how-to-with-scim 
  endpoint = "https://scim.eu-central-1.amazonaws.com/d-99672f310a/scim/v2/"
  # https://eu-central-1.signin.aws/platform/login?workflowStateHandle=d65b1d13-e8e4-4a53-a900-29ad0a89b1df
  # https://vejlupek.awsapps.com
  token    = "***"
}
