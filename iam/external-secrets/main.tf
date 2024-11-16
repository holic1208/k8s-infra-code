module "external-secrets" {
  source = "../../module/iam/external-secrets"

  name      = "eks"
  irsa_arn  = data.terraform_remote_state.irsa.outputs.irsa_arn
  eks_oidc  = data.terraform_remote_state.eks.outputs.eks_oidc
  sa_name   = "external-secrets"
}
