resource "helm_release" "metrics-server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  version    = "7.2.16"
  namespace  = "kube-system"

  set {
    name  = "nodeSelector.role"
    value = "monitoring"
  }
  
  set {
    name  = "apiService.create"
    value = "true"
  }
}

resource "helm_release" "aws-load-balancer-controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.8.1"
  namespace  = "kube-system"

  set {
    name  = "nodeSelector.role"
    value = "general"
  }

  set {
    name  = "clusterName"
    value = data.terraform_remote_state.eks.outputs.eks_id
  }

  set {
    name  = "region"
    value = "ap-northeast-2"
  }

  set {
    name  = "vpcId"
    value = data.terraform_remote_state.vpc.outputs.vpc_id
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = data.terraform_remote_state.aws-load-balancer-controller.outputs.aws-load-balancer-controller_role_arn
  }

# from v2.5, the default option is true. If you deploy multiple helm cahrt at the same time, you don't need to use that option if you use it or set depends_on to another helm chart
  set {
    name  = "enableServiceMutatorWebhook"
    value = "false"
  }
}

resource "helm_release" "external-dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  version    = "1.15.0"
  namespace  = "kube-system"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = data.terraform_remote_state.external-dns.outputs.external-dns_role_arn
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "nodeSelector.role"
    value = "general"
  }
}

resource "helm_release" "external-secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.10.0"
  namespace  = "external-secrets"

  set {
    name  = "global.nodeSelector.role"
    value = "general"
  }

  set {
    name  = "fullnameOverride"
    value = "external-secrets"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = data.terraform_remote_state.external-secrets.outputs.external-secrets_role_arn
  }

  depends_on = [
    kubernetes_namespace.external_secrets
  ]
}
