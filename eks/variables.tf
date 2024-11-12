variable "eks_version" {
  default = "1.29"
}

variable "vpc_public_access_cidrs" {
  default = ["0.0.0.0/0"]
}

variable "account_id" {
  default = ["985522651362"]
}

variable "region" {
  default = "ap-northeast-2"
}
