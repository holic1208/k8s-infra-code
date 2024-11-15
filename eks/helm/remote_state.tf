data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "sangun-admin"

    workspaces = {
      name = "base-infra-code_network_vpc"
    }
  }
}

data "terraform_remote_state" "eks" {
  backend = "remote"

  config = {
    organization = "sangun-admin"

    workspaces = {
      name = "k8s-infra-code_eks"
    }
  }
}

data "terraform_remote_state" "aws-load-balancer-controller" {
  backend = "remote"

  config = {
    organization = "sangun-admin"

    workspaces = {
      name = "k8s-infra-code_iam_aws-load-balancer-controller"
    }
  }
}
