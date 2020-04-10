resource "aws_eks_node_group" "cluster" {
  cluster_name    = aws_eks_cluster.eks_cluster.name

  node_group_name = format("%s-nodes", var.cluster_name)

  node_role_arn   = aws_iam_role.eks_nodes_role.arn

  subnet_ids      = [
    var.private_subnet_1a.id,
    var.private_subnet_1c.id
  ]

  remote_access {
      ec2_ssh_key = var.cluster_key.key_name
      source_security_group_ids = [
          aws_security_group.cluster_bastion_sg.id
      ]
  }

  instance_types = var.nodes_instances_sizes

  scaling_config {
    desired_size = lookup(var.auto_scale_options,  "desired")
    max_size     = lookup(var.auto_scale_options,  "max")
    min_size     = lookup(var.auto_scale_options,  "min")
  }

  tags = map(
    "Name", format("%s-nodes", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}", "owned"
  )

  depends_on = [
    aws_iam_role_policy_attachment.worker-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.worker-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.worker-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
