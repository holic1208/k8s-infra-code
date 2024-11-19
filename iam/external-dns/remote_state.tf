data "terraform_remote_state" "eks" {
  backend = "remote"

  config = {
    organization = "sangun-admin"

    workspaces = {
      name = "k8s-infra-code_eks"
    }
  }
}
