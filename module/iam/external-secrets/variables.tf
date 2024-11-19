variable "name" {
  type    = string
  default = ""
}

variable "eks_name" {
  type    = string
  default = ""
}

variable "sa_name" {
  type    = string
  default = ""
}

variable "namespace" {
  type    = string
  default = "external-secrets"
}
