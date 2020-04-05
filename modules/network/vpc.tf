resource "aws_vpc" "cluster_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = map(
    "Name", "${var.cluster_name}-vpc",
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )

}
