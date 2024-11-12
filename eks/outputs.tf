output "eks_id" {
  value = module.eks.eks_id
}

output "eks_endpoint" {
  value = module.eks.eks_endpoint
}

output "eks_ca_certificate" {
  value = module.eks.eks_ca_certificate
}

output "eks_oidc" {
  value = module.eks.eks_oidc
}

output "eks_version" {
  value = module.eks.eks_version
}