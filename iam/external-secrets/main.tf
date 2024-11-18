module "external-secrets" {
  source = "../../module/iam/external-secrets"

  name     = "eks"
  eks_name = data.terraform_remote_state.eks.outputs.eks_id
  sa_name  = "external-secrets"
}
