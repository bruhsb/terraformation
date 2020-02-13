
// resource "helm_release" "redis_cache" {
//   name          = "redis"
//   namespace     = "redis"
//   version       = "10.0.1"
//   chart         = "stable/redis"
//   reuse         = true
//   reuse_values  = true
//   recreate_pods = false
//   force_update  = true

//   values = [
//     file("./helmfiles/redis.yaml"),
//   ]
//   set {
//     name  = "usePassword"
//     value = "false"
//   }
// }

