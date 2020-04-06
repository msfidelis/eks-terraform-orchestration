resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = format("/aws/eks/%s/cluster", var.cluster_name)
  retention_in_days = 7
}