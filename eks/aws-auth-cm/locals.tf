locals {
  node = [
    {
      rolearn  = "arn:aws:iam::985522651362:role/eks-node-role"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]

  adminrole = [
    {
      rolearn  = "arn:aws:iam::985522651362:role/kubectl-admin_instance-role"
      username = "k8s-infra-admin-role"
      groups   = ["system:masters"]
    }
  ]

  aws-auth-data = {
    mapRoles = yamlencode(concat(local.node, local.adminrole))
  }
}
