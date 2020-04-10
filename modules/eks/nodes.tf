resource "aws_security_group" "cluster_nodes_sg" {
  name = format("%s-nodes-sg", var.cluster_name)

  vpc_id = var.cluster_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-nodes-sg", var.cluster_name)
  }
}

resource "aws_security_group_rule" "cluster_nodes_ingress_self" {
  description       = "self"
  protocol          = "-1"
  security_group_id = aws_security_group.cluster_nodes_sg.id
  self              = true
  from_port         = 0
  to_port           = 65535
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_nodes_ingress_master" {
  description              = "master"
  protocol                 = "-1"
  security_group_id        = aws_security_group.cluster_nodes_sg.id
  source_security_group_id = aws_security_group.cluster_master_sg.id
  from_port                = 0
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_ingress_workstation_ssh" {
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster_nodes_sg.id
  from_port         = 22
  to_port           = 22
  type              = "ingress"
}


data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = [format("amazon-eks-node-%s-v*", aws_eks_cluster.eks_cluster.version)]
  }

  most_recent = true
  owners      = ["602401143452"]
}

# data "template_file" "user_data_nodes" {
#   template = file(format("%s/templates/user-data/nodes.sh", path.module))
#   vars = {
#     cluster_name        = var.cluster_name
#     cluster_endpoint    = aws_eks_cluster.eks_cluster.endpoint
#     cluster_certificate = aws_eks_cluster.eks_cluster.certificate_authority.0.data
#   }
# }

# resource "aws_launch_template" "nodes" {

#   name_prefix   = format("%s-nodes-template", var.cluster_name)
#   image_id      = data.aws_ami.eks_worker.id
#   instance_type = var.nodes_instances_sizes[0]

#   key_name      = var.cluster_key.id

#   user_data = base64encode(data.template_file.user_data_nodes.rendered)

#   vpc_security_group_ids      = [ 
#     aws_security_group.cluster_nodes_sg.id 
#   ]

#   lifecycle {
#     create_before_destroy = true
#   }

#   iam_instance_profile {
#     name = aws_iam_instance_profile.worker_node.name
#   }

#   instance_initiated_shutdown_behavior = "terminate"

#   # instance_market_options {

#   #   market_type = "spot"

#   #   spot_options {
#   #     instance_interruption_behavior = "terminate"
#   #     max_price = var.spot_maximum_price
#   #   }  

#   # }

#   monitoring {
#     enabled = true
#   }    

#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#       "kubernetes.io/cluster/${var.cluster_name}" = "owned"
#       Name = format("%s-node", var.cluster_name)
#     }
#   }

# }

# resource "aws_autoscaling_group" "nodes" {
#   availability_zones       = [ format("%sa", var.aws_region), format("%sc", var.aws_region) ]
#   desired_capacity   = lookup(var.auto_scale_options,  "desired")
#   max_size           = lookup(var.auto_scale_options,  "max")
#   min_size           = lookup(var.auto_scale_options,  "min")

#   vpc_zone_identifier       = [ 
#     var.private_subnet_1a.id,
#     var.private_subnet_1c.id
#   ]

#   mixed_instances_policy {
#     launch_template {
#       launch_template_specification {
#         launch_template_id = aws_launch_template.nodes.id
#         version = "$Latest"
#       }

#     dynamic "override" {
#       for_each = var.nodes_instances_sizes
#       content {
#         instance_type     = override.value
#         weighted_capacity = 1
#       }
#     }

#     }
#   }

#   # target_group_arns = [  ]
# }