resource "aws_iam_role_policy_attachment" "ebs-csi-driver_policy" {
  role       = aws_iam_role.ebs-csi-driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "ebs-csi-driver_role" {
  name               = format("${var.name}-%s-%s-%s-%s", "ebs", "csi", "driver", "role")
  assume_role_policy = data.aws_iam_policy_document.policy_document.json

  tags = {
    Name = format("${var.name}-%s-%s", "ebs-csi-driver", "role")
  }
}

resource "aws_eks_pod_identity_association" "ebs-csi-driver_association" {
  cluster_name    = var.eks_name
  namespace       = var.namespace
  service_account = var.sa_name
  role_arn        = aws_iam_role.ebs-csi-driver_role.arn
}
