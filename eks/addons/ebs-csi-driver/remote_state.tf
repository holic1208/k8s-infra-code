data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "backend-k8s-infra-code"
    key    = "eks/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "ebs-csi-driver" {
  backend = "s3"

  config = {
    bucket = "backend-k8s-infra-code"
    key    = "iam/ebs-csi-driver/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

