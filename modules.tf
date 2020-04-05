module "network" {
  source         = "./modules/network"
  cluster_name   = var.cluster_name
#   alb_port       = "${var.alb_port}"
  aws_region     = var.aws_region
}

