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
