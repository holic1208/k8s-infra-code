module "ebs-csi-driver" {
  source = "../../module/iam/ebs-csi-driver"

  name      = "eks"
  eks_name  = data.terraform_remote_state.eks.outputs.eks_id
  sa_name   = "ebs-csi-controller-sa"
}
