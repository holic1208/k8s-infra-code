module "external-dns" {
  source = "../../module/iam/external-dns"

  name     = "eks"
  eks_name = data.terraform_remote_state.eks.outputs.eks_id
  sa_name  = "external-dns"
}
