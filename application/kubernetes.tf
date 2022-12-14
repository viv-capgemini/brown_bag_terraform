data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.cluster.outputs.cluster_id
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.cluster.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.cluster.outputs.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_namespace" "terramino" {
  metadata {
    name = "terramino"
  }
}

resource "kubernetes_deployment" "terramino" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.terramino.id
    labels = {
      app = var.application_name
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = var.application_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.application_name
        }
      }
      spec {
        container {
          image = "tr0njavolta/terramino"
          name  = var.application_name
        }
      }
    }
  }
}

resource "kubernetes_service" "terramino" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.terramino.id
  }
  spec {
    selector = {
      app = kubernetes_deployment.terramino.metadata[0].labels.app
    }
    port {
      port        = 8080
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
