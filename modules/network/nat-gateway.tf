resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.vpc_eip.id
  subnet_id     = aws_subnet.public_subnet_1a.id
  depends_on    = [aws_internet_gateway.gw]

  tags = map(
    "Name", format("%s-nat-gateway", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_eip" "vpc_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
  tags = map(
    "Name", format("%s-vpc-ip", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = map(
    "Name", format("%s-nat-route-table", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}", "shared"
  )
}

resource "aws_route" "nat_access" {
  route_table_id         = aws_route_table.nat_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
