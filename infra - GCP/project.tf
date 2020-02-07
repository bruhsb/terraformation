/******************************************
   Projects
 *****************************************/

# resource "google_project" "gcp_project" {
#   name                = var.gcp_project_name
#   project_id          = var.gcp_project_id
#   billing_account     = var.billing_account_id
#   auto_create_network = true
# }

/******************************************
   APIs - Services for GCP
 *****************************************/

module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "7.0.0"

  project_id = var.gcp_project_id

  activate_apis = [
    "oslogin.googleapis.com",
    "iam.googleapis.com",
    "containerregistry.googleapis.com",
    "pubsub.googleapis.com",
    "compute.googleapis.com",
    "iamcredentials.googleapis.com",
    "container.googleapis.com",
    "storage-api.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ]
}
