module "network" {
  source         = "./modules/network"
  cluster_name   = var.cluster_name
  aws_region     = var.aws_region
}

module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.cluster_name
  aws_region        = var.aws_region
  k8s_version       = var.k8s_version
  cluster_vpc       = module.network.cluster_vpc
  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1c = module.network.private_subnet_1c
  public_subnet_1a  = module.network.public_subnet_1a
  public_subnet_1c  = module.network.public_subnet_1c
  nodes_instances_sizes = var.nodes_instances_sizes
  spot_maximum_price = var.spot_maximum_price
  auto_scale_options = var.auto_scale_options

  cluster_key        = aws_key_pair.cluster_key
}
