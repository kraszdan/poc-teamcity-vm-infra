terraform {
  required_version = "~> 1.0.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.50.0"
    }
  }

  backend "local" {
    path = "output/prerequisites.tfstate"
  }
}

provider "aws" {
  region = var.region
}
