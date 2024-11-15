resource "aws_iam_role_policy_attachment" "ebs-csi-driver_policy" {
  role       = aws_iam_role.ebs-csi-driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.irsa_arn]
    }

    condition {
      test     = "StringEquals"
      variable = join(":", [element(regex("https://(.+)", var.eks_oidc), 0), "aud"])
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = join(":", [element(regex("https://(.+)", var.eks_oidc), 0), "sub"])
      values   = ["system:serviceaccount:${var.namespace}:${var.sa_name}"]
    }
  }
}

resource "aws_iam_role" "ebs-csi-driver_role" {
  name               = format("${var.name}-%s-%s-%s-%s", "ebs", "csi", "driver", "role")
  assume_role_policy = data.aws_iam_policy_document.policy_document.json

  tags = {
    Name = format("${var.name}-%s-%s", "ebs-csi-driver", "role")
  }
}
