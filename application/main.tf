provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

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