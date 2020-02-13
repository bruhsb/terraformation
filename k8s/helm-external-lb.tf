// # Chart Helm for install Nginx Ingress Controller
// # https://github.com/helm/charts/tree/master/stable/nginx-ingress

// resource "helm_release" "external_lb" {
//   name          = "external-lb"
//   namespace     = "ingress"
//   chart         = "stable/nginx-ingress"
//   repository    = data.helm_repository.stable.metadata[0].name
//   version       = "1.6.16"
//   reuse_values  = true
//   recreate_pods = true
//   force_update  = true

//   values = [
//     file("./helmfiles/nginx.yaml"),
//   ]

//   set {
//     name  = "controller.ingressClass"
//     value = "external"
//   }

//   set {
//     name  = "controller.service.annotations.cloud\\.google\\.com/load-balancer-type"
//     value = "external"
//   }

//   set {
//     name  = "controller.publishService.pathOverride"
//     value = "ingress/external-lb-nginx-ingress-controller"
//   }
// }
