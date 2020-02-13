// resource "helm_release" "opa" {
//   name          = "opa"
//   namespace     = "opa"
//   chart         = "stable/opa"
//   version       = "1.6.0"
//   reuse_values  = true
//   recreate_pods = true
//   force_update  = true
//   depends_on = [
//     module.kubernetes,
//     module.tiller,
//   ]
//   values = [
//     file("./helmfiles/opa.yaml"),
//   ]
// }

