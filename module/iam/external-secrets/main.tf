resource "aws_iam_role_policy_attachment" "external-secrets_policy" {
  role       = aws_iam_role.external-secrets_role.name
  policy_arn = aws_iam_policy.external-secrets_policy.arn
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

resource "aws_iam_policy" "external-secrets_policy" {
  name = format("${var.name}-%s-%s", "external-secrets", "policy")

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "external-secrets_role" {
  name               = format("${var.name}-%s-%s", "external-secrets", "role")
  assume_role_policy = data.aws_iam_policy_document.policy_document.json

  tags = {
    Name = format("${var.name}-%s-%s", "external-secrets", "role")
  }
}
