module "aws-load-balancer-controller" {
  source = "../../module/iam/aws-load-balancer-controller"

  name      = "eks"
  eks_name  = data.terraform_remote_state.eks.outputs.eks_id
  sa_name   = "aws-load-balancer-controller"
}
