
# module for Tiller / Helm
## Docs: https://github.com/sagikazarmark/terraform-tiller
### Why use it? >> https://github.com/terraform-providers/terraform-provider-helm/issues/56

module "tiller" {
  source           = "github.com/bruhsb/terraform-tiller?ref=v0.2.2"
  rbac_enabled     = "true"
  tiller_image     = "gcr.io/kubernetes-helm/tiller"
  tiller_version   = "v2.13.1"
  tiller_namespace = "kube-system"

  depends_module = module.kubernetes.name #TODO - Create Docs

}

# module for GKE - Google Kubernetes Enginer
## Docs: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine

module "kubernetes" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~>7.0"

  providers = {
    google = google
  }

  kubernetes_version         = var.k8s_version
  project_id                 = var.gcp_project_id
  name                       = var.cluster_name[0]
  regional                   = var.regional_cluster
  zones                      = var.zones
  region                     = var.region
  network_project_id         = var.gcp_project_id # useful for VPC-Shared
  network                    = google_compute_network.gke_vpc.name
  subnetwork                 = google_compute_subnetwork.gke_subnetwork.name
  ip_range_pods              = "subnet-pods"
  ip_range_services          = "subnet-services"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  remove_default_node_pool   = false

  disable_legacy_metadata_endpoints = true
  monitoring_service                = "none"
  logging_service                   = "none"

  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "ALL"
    },
  ]

  node_pools = [
    {
      name               = "${var.project_id}-pool"
      machine_type       = "n1-standard-1"
      min_count          = 0
      max_count          = 4
      disk_size_gb       = 30
      disk_type          = "pd-standard"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
      initial_node_count = 1
    },
    { # Pool for infrastructure services.
      name               = "infra-nodes"
      machine_type       = "n1-standard-4"
      min_count          = 1
      max_count          = 3
      disk_size_gb       = 30
      disk_type          = "pd-standard"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    infra-nodes = []
  }

  node_pools_metadata = {
    all         = {}
    infra-nodes = {}
  }

  node_pools_labels = {
    all = {}
    infra-nodes = {
      role = "infra"
    }
  }

  # Used only module_beta' 
  # See: > https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/pull/228
  // node_pools_taints = {
  //   all = []

  //   infra-nodes = [
  //     {
  //       key    = "infra-workloads"
  //       value  = true
  //       effect = "NO_SCHEDULE"
  //     },
  //   ]
  // }

  node_pools_tags = {
    all = [
      "kubernetes",
      "default-allow-ssh",
    ]
    infra-nodes = []
  }
}

