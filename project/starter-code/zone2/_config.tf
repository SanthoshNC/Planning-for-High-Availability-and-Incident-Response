terraform {
  backend "s3" {
    bucket = "udacity-tf-santhoshnc1"
    key    = "terraform/terraform.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {
  region = "us-west-1"
  #alias  = "usw1"
  #profile = "default"

  default_tags {
    tags = local.tags
  }
}
