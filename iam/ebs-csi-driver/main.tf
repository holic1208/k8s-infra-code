module "ebs-csi-driver" {
  source = "../../module/iam/ebs-csi-driver"

  name      = "eks"
  sa_name   = "ebs-csi-controller-sa"
}
