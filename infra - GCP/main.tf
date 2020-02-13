# *Main Providers and pre-requisites
data "google_client_config" "default" {}

terraform { #TODO - Create Docs
  required_version = ">= 0.12"
  required_providers {

    google-beta = "~> 3.7.0" # https://github.com/terraform-providers/terraform-provider-google/releases
    google      = "~> 3.7.0" # https://github.com/terraform-providers/terraform-provider-google-beta/releases
    kubernetes  = "~> 1.10"  # https://github.com/terraform-providers/terraform-provider-kubernetes/releases

  }

  backend "gcs" {
    bucket = "terraform-state-labs-k8s"
    prefix = "infra-state"
  }
}

provider "google-beta" {

  credentials = var.gcp_credentials_json
  project     = var.gcp_project_id
  region      = var.region
  zone        = var.zone
}

provider "google" {

  credentials = var.gcp_credentials_json
  project     = var.gcp_project_id
  region      = var.region
  zone        = var.zone
}

provider "kubernetes" { #TODO - Create Docs

  load_config_file       = false
  host                   = "https://${module.kubernetes.endpoint}"
  cluster_ca_certificate = base64decode(module.kubernetes.ca_certificate)
  token                  = data.google_client_config.default.access_token
}
