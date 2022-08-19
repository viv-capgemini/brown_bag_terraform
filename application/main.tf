provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

data "terraform_remote_state" "cluster" {
  backend = "remote"

  config = {

    organization = "brown_bag_demo"
    workspaces = {
          name = "cluster"
    }
  }
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {

    organization = "brown_bag_demo"
    workspaces = {
          name = "network"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.6"
  cloudwatch_log_group_name = "brown_bag_logs"
}