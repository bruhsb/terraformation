

# Private DNS zone to cluster
resource "google_dns_managed_zone" "private" {
  project     = var.gcp_project_id
  name        = "private-dns-k8s"
  dns_name    = "${var.project_id}.k8s.space."
  description = "Private ${var.project_id} DNS zone"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.gke_vpc.self_link
    }
  }
}

resource "google_dns_record_set" "private_internal_ingress" {
  name         = "${var.project_id}.k8s.space."
  type         = "A"
  ttl          = 10
  managed_zone = google_dns_managed_zone.private.name
  project      = var.gcp_project_id
  rrdatas      = [google_compute_address.internal_ingress.address]
}

resource "google_dns_record_set" "private_internal_wildcard" {
  name         = "*.${var.project_id}.k8s.space."
  type         = "CNAME"
  ttl          = 10
  managed_zone = google_dns_managed_zone.private.name
  project      = var.gcp_project_id
  rrdatas      = [google_dns_record_set.private_internal_ingress.name]
}
