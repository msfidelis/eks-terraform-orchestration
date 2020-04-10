output "bastion" {
    value = aws_instance.bastion
}

output "cluster" {
    value = aws_eks_cluster.eks_cluster
}