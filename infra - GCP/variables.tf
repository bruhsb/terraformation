# ##########################
# ### GENERAL  VARIABLES ###
# ##########################


################################
#### Project & General Configs

variable "project_id" {
  type    = string
  default = "labs-k8s"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP project id that will be used"
  default     = "k8slabs10"
}

variable "gcp_project_name" {
  type        = string
  description = "GCP project id that will be used"
  default     = "k8slabs10"
}

variable "bucket_terraform_state" {
  type    = string
  default = "terraform-state-labs-k8s"
}

#
variable "billing_account_id" {
  type        = string
  description = "Billing account used for payment in this project"
  default     = "011FFD-546E46-C9AEE8"
}

variable "gcp_credentials_json" {
  type        = string
  description = "File for access to GCP Project"
  default     = ""
}

#
variable "region" {
  type        = string
  description = "GCP region, e.g. southamerica-east1"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  default     = "us-east1-c"
}


################################
#### Network

variable "vpc_ip_cidr_ranges" {
  type        = list(string)
  description = "List with three ranges for vpc subnetwork and its secondary cidrs"

  default = [
    "10.100.240.0/20",
    "10.101.240.0/20",
    "10.102.240.0/20",
    "10.103.240.0/28",
  ]
}


################################
#### Kubernetes

variable "cluster_name" {
  type        = list(string)
  description = "GCP GKE Cluster name"
  default = [
    "labs-k8s"
  ]
}

variable "regional_cluster" {
  type    = bool
  default = false
}

variable "zones" {
  type        = list(string)
  description = "GCP GKE Cluster zones"
  default = [
    "us-east1-c"
  ]
}

variable "k8s_version" {
  type    = string
  default = "1.15.8-gke.2" #"1.14.8-gke.17"
}

# TODO - Incluir variavel com lista de Nodes a serem criados
# variable "node_pools" {
#   type = map(list)
# }
