// resource "helm_release" "postgresql" {
//   name          = "postgresql"
//   namespace     = "postgresql"
//   version       = "7.6.0"
//   chart         = "stable/postgresql"
//   reuse         = true
//   reuse_values  = true
//   recreate_pods = false
//   force_update  = true

//   values = [
//     file("${path.module}/helmfiles/postgresql.yaml"),
//   ]
// #   set {
// #     name  = "usePassword"
// #     value = "false"
// #   }
// }
