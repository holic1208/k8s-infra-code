resource "aws_eks_addon" "pod-identity-agent" {
  cluster_name = data.terraform_remote_state.eks.outputs.eks_id

  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.3.2-eksbuild.2"
  resolve_conflicts_on_update = "PRESERVE"
}
