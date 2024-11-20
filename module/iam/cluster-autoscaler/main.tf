resource "aws_iam_role_policy_attachment" "cluster-autoscaler_policy" {
  role       = aws_iam_role.cluster-autoscaler_role.name
  policy_arn = aws_iam_policy.cluster-autoscaler_policy.arn
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

resource "aws_iam_policy" "cluster-autoscaler_policy" {
  name = format("${var.name}-%s-%s", "cluster-autoscaler", "policy")

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/k8s.io/cluster-autoscaler/enabled": "true",
                    "aws:ResourceTag/k8s.io/cluster-autoscaler/${var.eks_name}": "owned"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:DescribeTags",
                "ec2:DescribeImages",
                "ec2:DescribeInstanceTypes",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:GetInstanceTypesFromInstanceRequirements",
                "eks:DescribeNodegroup"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "cluster-autoscaler_role" {
  name               = format("${var.name}-%s-%s", "cluster-autoscaler", "role")
  assume_role_policy = data.aws_iam_policy_document.policy_document.json

  tags = {
    Name = format("${var.name}-%s-%s", "cluster-autoscaler", "role")
  }
}

resource "aws_eks_pod_identity_association" "cluster-autoscaler_association" {
  cluster_name    = var.eks_name
  namespace       = var.namespace
  service_account = var.sa_name
  role_arn        = aws_iam_role.cluster-autoscaler_role.arn
}
