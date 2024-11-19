terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "sangun-admin"

    workspaces {
      name = "k8s-infra-code_eks_addons_pod-identity-agent"
    }
  }
}
