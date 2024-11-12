resource "aws_eks_cluster" "eks" {
  name     = format("${var.name}-%s", "cluster")
  role_arn = aws_iam_role.eks_role.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.vpc_subnet_ids
    security_group_ids      = var.vpc_security_group_ids
    public_access_cidrs     = var.vpc_public_access_cidrs
    endpoint_private_access = var.vpc_endpoint_private_access
  }
}
