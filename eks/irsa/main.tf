resource "aws_iam_openid_connect_provider" "irsa" {
  url = data.terraform_remote_state.eks.outputs.eks_oidc

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}
