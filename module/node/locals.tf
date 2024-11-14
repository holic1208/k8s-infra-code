locals {
  node_configs = [
    {
      name        = "monitoring"
      node_labels = "role=monitoring"
    },
    {
      name        = "general"
      node_labels = "role=general"
    }
  ]

  user_data = <<-EOF
  #!/bin/bash -xe

  B64_CLUSTER_CA=${var.eks_ca}
  APISERVER_ENDPOINT=${var.apiserver_endpoint}
  /etc/eks/bootstrap.sh ${var.eks_name} --b64-cluster-ca $B64_CLUSTER_CA --apiserver-endpoint $APISERVER_ENDPOINT --kubelet-extra-args "--node-labels %s"
  EOF
}
