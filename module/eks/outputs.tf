output "eks_id" {
  value = aws_eks_cluster.eks.id
}

output "eks_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_ca_certificate" {
  value = aws_eks_cluster.eks.certificate_authority.0.data
}

output "eks_oidc" {
  value = flatten(aws_eks_cluster.eks[*].identity[*].oidc.0.issuer)[0]
}

output "eks_version" {
  value = aws_eks_cluster.eks.version
}