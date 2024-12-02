terraform {
  backend "s3" {
    bucket         = "backend-k8s-infra-code"
    key            = "eks/addons/ebs-csi-driver/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-lock-table"
  }
}
