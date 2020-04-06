resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.k8s_version
  vpc_config {
    security_group_ids = [aws_security_group.cluster_master_sg.id]
    subnet_ids = [
      var.private_subnet_1a.id,
      var.private_subnet_1c.id
    ]
  }

  tags = map(
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )

}

resource "aws_security_group" "cluster_master_sg" {
  name = format("%s-master-sg", var.cluster_name)

  vpc_id = var.cluster_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-master-sg", var.cluster_name)
  }
}

resource "aws_security_group_rule" "cluster_ingress_node_https" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster_master_sg.id
  source_security_group_id = aws_security_group.cluster_nodes_sg.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_ingress_workstation_https" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster_master_sg.id
  to_port           = 443
  type              = "ingress"
}
