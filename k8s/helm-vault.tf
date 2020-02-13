// resource "kubernetes_namespace" "vault" {
//   metadata {
//     name = "vault"

//     labels {
//       name = "vault"
//     }
//   }
// }

// resource "helm_release" "vault_webhook" {
//   name          = "vault-secrets-webhook"
//   repository    = "http://kubernetes-charts.banzaicloud.com/branch/master"
//   namespace     = "${kubernetes_namespace.vault.metadata.0.name}"
//   chart         = "vault-secrets-webhook"
//   version       = "0.3.10"
//   reuse         = true
//   reuse_values  = true
//   recreate_pods = false
//   force_update  = true

//   set {
//     name  = "debug"
//     value = true
//   }

//   set {
//     name  = "replicaCount"
//     value = 2
//   }

//   set {
//     name  = "image.tag"
//     value = "0.4.13"
//   }

//   set {
//     name  = "service.internalPort"
//     value = "8443"
//   }

//   set {
//     name  = "rabc.psp.enabled"
//     value = "true"
//   }
// }

// resource "helm_release" "vault" {
//   depends_on    = ["module.vault_bucket_serviceaccount"]
//   name          = "vault"
//   repository    = "http://kubernetes-charts.banzaicloud.com/branch/master"
//   namespace     = "${kubernetes_namespace.vault.metadata.0.name}"
//   chart         = "vault"
//   version       = "0.9.2"
//   reuse         = true
//   reuse_values  = true
//   recreate_pods = false
//   force_update  = true

//   values = [
//     "${file("./helmfiles/vault.yaml")}",
//   ]

//   set {
//     name = "vault.googleKms.region"
//     value = data.terraform_remote_state.gcp_project.output.gcp_region
//   }

//   set {
//     name = "vault.googleKms.project"
//     value = data.terraform_remote_state.gcp_project.output.gcp_project_id
//   }
// }


// module "service_accounts" {
//   source        = "terraform-google-modules/service-accounts/google"
//   version       = "~> 2.0"
//   project_id    = data.terraform_remote_state.gcp_project.output.gcp_project_id
//   names         = ["vault"]
//   generate_keys = true
//   project_roles = [
//     "${data.terraform_remote_state.gcp_project.output.gcp_project_id}=>roles/Owner",
//   ]
// }

// module "vault_bucket_serviceaccount" {
//   source            = "git::ssh://git@gitlab.idwall.space/ops/terraform/modules/kubernetes-secret-from-vault.git?ref=1.1.0"
//   name              = "vault-service-account"
//   namespace         = "vault"
//   is_credentials    = true
//   vault_secret_path = "ops/vault/google-service-account"
// }
