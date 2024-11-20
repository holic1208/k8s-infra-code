module "cluster-autoscaler" {
  source = "../../module/iam/cluster-autoscaler"

  name     = "eks"
  eks_name = data.terraform_remote_state.eks.outputs.eks_id
  sa_name  = "cluster-autoscaler"
}
