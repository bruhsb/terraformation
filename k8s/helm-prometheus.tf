
// #TODO - Review Prometheus
// data "template_file" "prometheus" {
//   template = file("${path.module}/helmfiles/prometheus.tpl.yaml")

//   vars = {
//     ssl_certificate_secret = ""
//     alertmanager_url       = "alertmanager.getupcloud.com"
//     prometheus_url         = "prometheus.getupcloud.com"
//     grafana_url            = "grafana.getupcloud.com"
//   }
// }

// # * Chart Helm for install Nginx Ingress Controller
// # https://github.com/helm/charts/tree/master/stable/prometheus-operator

// resource "helm_release" "prometheus" {
//   name          = "prom-op"
//   namespace     = "monitoring"
//   chart         = "stable/prometheus-operator"
//   repository    = data.helm_repository.stable.metadata[0].name
//   version       = "5.11.1"
//   reuse         = true
//   reuse_values  = true
//   recreate_pods = true
//   force_update  = true

//   values = [
//     data.template_file.prometheus.rendered,
//   ]

// }

