
// # Module for create Service Accounts
// # See: https://github.com/terraform-google-modules/terraform-google-service-accounts

// module "service_accounts_gitlab" {
//   source        = "terraform-google-modules/service-accounts/google"
//   version       = "~> 2.0"
//   project_id    = var.gcp_project_id
//   prefix        = var.project_id
//   generate_keys = true
//   names         = ["gitlab-ci"]
//   project_roles = ["${var.gcp_project_id}=>roles/editor"]
// }

resource "google_service_account" "gitlab_ci" {
  project      = var.gcp_project_id
  account_id   = "gitlab-ci"
  display_name = "GitLab CI"
}

resource "google_service_account_key" "gitlab_ci" {
  service_account_id = google_service_account.gitlab_ci.name
}

resource "google_project_iam_member" "project" {
  project = var.gcp_project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.gitlab_ci.email}"
}

output "gitlab_sa_pk" {
  sensitive = true
  value = google_service_account_key.gitlab_ci.private_key
}
