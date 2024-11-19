resource "aws_eks_addon" "ebs-csi-driver" {
  cluster_name = data.terraform_remote_state.eks.outputs.eks_id

  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.36.0-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE"
  service_account_role_arn    = data.terraform_remote_state.ebs-csi-driver.outputs.ebs-csi-driver_role_arn
}
