resource "aws_lb" "network" {
  name               = format("%s-nlb", var.cluster_name)
  internal           = false
  load_balancer_type = "network"

  subnets            = [
      var.private_subnet_1a.id,
      var.private_subnet_1c.id
  ]

  enable_deletion_protection = false

  tags = map(
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}