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
