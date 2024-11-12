variable "name" {
  type    = string
  default = ""
}

variable "eks_version" {
  type    = string
  default = ""
}

variable "vpc_subnet_ids" {
  type    = list(string)
  default = []
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}

variable "vpc_public_access_cidrs" {
  type    = list(string)
  default = []
}

variable "vpc_endpoint_private_access" {
  type    = string
  default = true
}
