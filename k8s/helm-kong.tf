
// # TODO: Create Docs about use kong with terraform

// data "helm_repository" "kong" {
//   name = "kong"
//   url  = "https://charts.konghq.com"
// }

// data "template_file" "kong" {
//   template = file("${path.module}/helmfiles/kong.tpl.yaml")

//   vars = { # TODO: Create integration with PostgreSQL Chart
//     env_pg_host     = "postgresql.postgresql.svc.cluster.local"
//     env_pg_port     = "5432"
//     env_pg_user     = "postgres"
//     env_pg_password = "postgres"
//     env_pg_database = "postgres"
//     replicaCount    = "2"
//   }
// }

// # * Chart Helm for install Kong for k8s
// # https://github.com/Kong/charts/tree/master/charts/kong

// resource "helm_release" "kong" {
//   name          = "kong"
//   namespace     = "kong"
//   chart         = "kong/kong"
//   repository    = data.helm_repository.kong.metadata[0].name
//   version       = "1.1.1"
//   reuse         = true
//   reuse_values  = false
//   recreate_pods = true
//   force_update  = true

//   values = [
//     data.template_file.kong.rendered,
//   ]

// }

