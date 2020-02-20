
/******************************************
   VPC - Network
 *****************************************/
# VPC for GKE
resource "google_compute_network" "gke_vpc" {
  name                    = "${var.project_id}-vpc"
  description             = "General VPC Network"
  auto_create_subnetworks = "false"
  depends_on = [
    module.project-services,
    # google_project.gcp_project,
  ]
}

# Subnets for GKE Resources
resource "google_compute_subnetwork" "gke_subnetwork" {
  name          = "${var.project_id}-subnetwork"
  ip_cidr_range = var.vpc_ip_cidr_ranges[0]
  region        = var.region
  network       = google_compute_network.gke_vpc.self_link

  secondary_ip_range {
    range_name    = "subnet-pods"
    ip_cidr_range = var.vpc_ip_cidr_ranges[1]
  }

  secondary_ip_range {
    range_name    = "subnet-services"
    ip_cidr_range = var.vpc_ip_cidr_ranges[2]
  }

  depends_on = [
    module.project-services,
    # google_project.gcp_project,
  ]
}

# Internal & External Ingress IP Address

resource "google_compute_address" "internal_ingress" {

  name         = "${var.project_id}-internal-ingress"
  description  = "Internal ingress endpoint"
  project      = var.gcp_project_id
  address_type = "INTERNAL"

  #TODO: Create Docs
  subnetwork = google_compute_subnetwork.gke_subnetwork.self_link
  address    = cidrhost(var.vpc_ip_cidr_ranges[0], 10)

}

resource "google_compute_address" "external_ingress" {

  name         = "${var.project_id}-external-ingress"
  description  = "External ingress endpoint"
  project      = var.gcp_project_id
  address_type = "EXTERNAL"
}
