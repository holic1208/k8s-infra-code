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
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

# from v2.5, the default option is true. If you deploy multiple helm chart at the same time, you don't need to use that option if you use it or set depends_on to another helm chart
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
    name  = "nodeSelector.role"
    value = "general"
  }

  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }

  set {
    name  = "policy"
    value = "sync"
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
    name  = "serviceAccount.name"
    value = "external-secrets"
  }

  depends_on = [
    kubernetes_namespace.external_secrets
  ]
}

resource "helm_release" "cluster-autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.43.2"
  namespace  = "kube-system"

  set {
    name  = "nodeSelector.role"
    value = "general"
  }

  set {
    name  = "fullnameOverride"
    value = "cluster-autoscaler"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = data.terraform_remote_state.eks.outputs.eks_id
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "awsRegion"
    value = "ap-northeast-2"
  }
}
