module "external-dns" {
  source = "../../module/iam/external-dns"

  name     = "eks"
  irsa_arn = data.terraform_remote_state.irsa.outputs.irsa_arn
  eks_oidc = data.terraform_remote_state.eks.outputs.eks_oidc
  sa_name  = "external-dns"
}
