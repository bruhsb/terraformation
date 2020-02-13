# *Main Providers and pre-requisites
data "google_client_config" "default" {
}

terraform {
  required_version = ">= 0.12"
  required_providers {

    google-beta = "~> 3.7"  # https://github.com/terraform-providers/terraform-provider-google/releases
    google      = "~> 3.7"  # https://github.com/terraform-providers/terraform-provider-google-beta/releases
    kubernetes  = "~> 1.11" # https://github.com/terraform-providers/terraform-provider-kubernetes/releases
    helm        = "~> 0.10" # https://github.com/terraform-providers/terraform-provider-helm/releases

  }

  backend "gcs" {
    bucket = "terraform-state-labs-k8s"
    prefix = "k8s-state"
  }
}

# Remote State: State from infraestructure
data "terraform_remote_state" "gcp_project" { #TODO - Create Docs
  backend = "gcs"
  config = {
    bucket = "terraform-state-getup-poc"
    prefix = "infra-state"
  }
}

provider "google-beta" {

  project = local.gcp_project_id
  region  = local.gcp_region
  zone    = local.gcp_zone
}

provider "google" {

  project = local.gcp_project_id
  region  = local.gcp_region
  zone    = local.gcp_zone
}

provider "kubernetes" { #TODO - Create Docs

  load_config_file       = false
  host                   = "https://${local.gke_endpoint}"
  cluster_ca_certificate = base64decode(local.gke_ca)
  token                  = data.google_client_config.default.access_token

}

provider "helm" { #TODO - Create Docs

  install_tiller  = false
  service_account = "tiller"
  namespace       = "kube-system"
  kubernetes {
    load_config_file       = false
    host                   = "https://${local.gke_endpoint}"
    cluster_ca_certificate = base64decode(local.gke_ca)
    token                  = data.google_client_config.default.access_token
  }
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
