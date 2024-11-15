module "aws-load-balancer-controller" {
  source = "../../module/iam/aws-load-balancer-controller"

  name      = "eks"
  irsa_arn  = data.terraform_remote_state.irsa.outputs.irsa_arn
  eks_oidc  = data.terraform_remote_state.eks.outputs.eks_oidc
  sa_name   = "aws-load-balancer-controller"
}
