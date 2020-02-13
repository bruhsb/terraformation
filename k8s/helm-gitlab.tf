// resource "helm_release" "gitlab" {
//   name          = "gitlab"
//   namespace     = "gitlab"
//   chart         = "gitlab"
//   repository    = data.helm_repository.gitlab.metadata[0].name
//   version       = "2.5.1"
//   reuse         = true
//   reuse_values  = false
//   recreate_pods = false
//   force_update  = true
//   timeout       = 600

//   values = [
//     file("./helmfiles/gitlab.yaml"),
//   ]
// }

// data "helm_repository" "gitlab" {
//   name = "gitlab"
//   url  = "https://charts.gitlab.io/"
// }


// # Module for create Service Accounts
// # See: https://github.com/terraform-google-modules/terraform-google-service-accounts

// module "service_accounts_gitlab" {
//   source        = "terraform-google-modules/service-accounts/google"
//   version       = "~> 2.0"
//   project_id    = local.gcp_project_id
//   prefix        = local.project_id
//   generate_keys = true
//   names         = ["gitlab-ci"]
//   project_roles = ["${local.gcp_project_id}=>roles/editor"]
// }

// #TODO - Create Docs about this module and service accounts

// # Outputs of service accounts

// locals {
//   gitlab_emails     = module.service_accounts_gitlab.emails
//   gitlab_iam_emails = module.service_accounts_gitlab.iam_emails
//   gitlab_keys       = module.service_accounts_gitlab.keys
// }
