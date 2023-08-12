terraform {
  required_version = "~> 1.5.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.60.0"
    }
    archive = {
        source = "hashicorp/archive"
        version = "2.3.0"
    }
  }
  backend "local" {  
  }
#   backend "s3" { 
#   }
}

provider "aws" {
    region = "ap-southeast-2"
}