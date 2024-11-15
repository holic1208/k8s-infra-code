variable "name" {
  type    = string
  default = ""
}

variable "irsa_arn" {
  type    = string
  default = ""
}

variable "eks_oidc" {
  type    = string
  default = ""
}

variable "sa_name" {
  type    = string
  default = ""
}

variable "namespace" {
  type    = string
  default = "kube-system"
}
