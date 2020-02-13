resource "kubernetes_storage_class" "fast-reginal" {
  metadata {
    name = "fast-reginal"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Delete"
  parameters = {
    type  = "pd-ssd"
    zones = "us-east1-d, us-east1-b, us-east1-c"
  }
}

resource "kubernetes_storage_class" "fast-zonal" {
  metadata {
    name = "fast-zonal"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Delete"
  parameters = {
    type = "pd-ssd"
  }
}