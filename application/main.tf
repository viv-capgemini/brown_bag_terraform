# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
# }

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

  cluster_name    = data.terraform_remote_state.cluster.outputs.cluster_name

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnets
    }