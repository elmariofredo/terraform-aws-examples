provider "aws" {
  default_tags {
    tags = {
      Environment = "Games"
      Owner       = "Kids"
    }
  }
}
