provider "aws" {
  region = "eu-central-1"
}

provider "kubernetes" {
  host                   = module.kubernetes.module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.kubernetes.module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # וודא ששם הקלאסטר כאן תואם למשתנה שלך
    args = ["eks", "get-token", "--cluster-name", module.kubernetes.module.eks.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.kubernetes.module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = ["eks", "get-token", "--cluster-name", module.kubernetes.module.eks.cluster_name]
    }
  }
}