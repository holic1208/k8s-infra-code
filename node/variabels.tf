variable "account_id" {
  default = ["985522651362"]
}

variable "region" {
  default = "ap-northeast-2"
}

variable "instance_type" {
  default = "t3.small"
}

variable "volume_size" {
  default = 6
}

variable "volume_type" {
  default = "gp3"
}

variable "health_check_type" {
  default = "EC2"
}

variable "name" {
  default = "eks"
}
