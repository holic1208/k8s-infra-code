resource "helm_release" "metrics-server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  version    = "7.2.6"
  namespace  = "kube-system"

  set {
    name  = "nodeSelector.role"
    value = "monitoring"
  }
}
