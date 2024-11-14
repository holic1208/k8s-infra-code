data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "sangun-admin"

    workspaces = {
      name = "base-infra-code_network_vpc"
    }
  }
}

data "terraform_remote_state" "sg" {
  backend = "remote"

  config = {
    organization = "sangun-admin"

    workspaces = {
      name = "base-infra-code_network_sg"
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
