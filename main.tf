terraform {
  required_version = ">= 1.12.0"

  backend "s3" {
    bucket = "TERRAFORM_STATE_BUCKET"
    key    = "global/s3/terraform.tfstate"
    region = "us-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = ">= 6.14.0"
    }
  }
}

provider "aws" {
  region = local.region
}

provider "aws" {
  alias = "workflows"

  region = local.region

  default_tags {
    tags = {
      (module.aspect_workflows.cost_allocation_tag) = module.aspect_workflows.cost_allocation_tag_value
    }
  }
}
