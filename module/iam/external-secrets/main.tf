resource "aws_iam_role_policy_attachment" "external-secrets_policy" {
  role       = aws_iam_role.external-secrets_role.name
  policy_arn = aws_iam_policy.external-secrets_policy.arn
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

resource "aws_eks_pod_identity_association" "external-secrets_association" {
  cluster_name    = var.eks_name
  namespace       = var.namespace
  service_account = var.sa_name
  role_arn        = aws_iam_role.external-secrets_role.arn
}
