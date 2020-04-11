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