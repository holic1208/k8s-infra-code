data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "backend-base-infra-code"
    key    = "network/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "backend-k8s-infra-code"
    key    = "eks/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
