module "ebs-csi-driver" {
  source = "../../module/iam/ebs-csi-driver"

  name      = "eks"
  irsa_arn  = data.terraform_remote_state.irsa.outputs.irsa_arn
  eks_oidc  = data.terraform_remote_state.eks.outputs.eks_oidc
  sa_name   = "ebs-csi-controller-sa"
}
