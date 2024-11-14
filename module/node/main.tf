resource "aws_launch_template" "lt" {
  for_each = { for node in local.node_configs : node.name => node }

  name_prefix            = format("${var.name}-%s-%s-%s", each.value.name, "node", "lt")
  image_id               = data.aws_ssm_parameter.node_ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  user_data              = "${base64encode(format(local.user_data, each.value.node_labels))}"

  iam_instance_profile {
    arn = aws_iam_instance_profile.node_instance_profile.arn
  }
  
  metadata_options {
    http_tokens = "required"
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      encrypted   = var.volume_encrypted
      kms_key_id  = var.kms_key_id
      volume_size = var.volume_size
      volume_type = var.volume_type
    }
  }
}

resource "aws_autoscaling_group" "node" {
  for_each = { for node in local.node_configs : node.name => node }

  name                 = format("${var.name}-%s-%s-%s", each.value.name, "worker", "group")
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = var.health_check_type

  launch_template {
    id      = aws_launch_template.lt[each.value.name].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = format("${var.name}-%s-%s-%s", each.value.name, "worker", "group")
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.eks_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/${var.eks_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = "true"
    propagate_at_launch = true
  }
}

data "aws_ssm_parameter" "node_ami" {
  name = "/aws/service/eks/optimized-ami/${var.eks_version}/amazon-linux-2/recommended/image_id"
}
