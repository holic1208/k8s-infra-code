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
