terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
  required_version = "~>1.7.0"
}

provider "aws" {
  # Configuration options
  region = "eu-west-3"
  default_tags {
    tags = var.tags
  }
}
