#################
#### OUTPUTS ####
#################

#TODO - Create Docs with Outputs

output "project_id" {
  value = var.project_id
}

output "gcp_project_id" {
  value = var.gcp_project_id
}

output "gcp_region" {
  value = var.region
}

output "gcp_zone" {
  value = var.zone
}

output "gcp_vpc_network_name" {
  value = google_compute_network.gke_vpc.name
}

output "gcp_vpc_subnetwork_name" {
  value = google_compute_subnetwork.gke_subnetwork.name
}

output "gke_endpoint" {
  value     = module.kubernetes.endpoint
  sensitive = true
}

output "gke_ca" {
  value     = module.kubernetes.ca_certificate
  sensitive = true
}

output "gke_command-line_access" {
  value = "gcloud container clusters get-credentials ${var.project_id} --zone ${var.zone} --project ${var.gcp_project_id}"
}