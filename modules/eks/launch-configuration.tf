data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.eks_cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

data "template_file" "user_data_nodes" {
  template = "${file("${path.module}/templates/user-data.sh")}"
  vars = {
    cluster_name        = var.cluster_name
    cluster_endpoint    = aws_eks_cluster.eks_cluster.endpoint
    cluster_certificate = aws_eks_cluster.eks_cluster.certificate_authority.0.data
  }
}

resource "aws_launch_configuration" "nodes" {
  iam_instance_profile = aws_iam_instance_profile.worker-node.name
  image_id             = data.aws_ami.eks-worker.id
  instance_type        = "t2.micro"
  name_prefix          = format("%s-node", var.cluster_name)
  security_groups      = [ aws_security_group.worker-node-sg.id ]
  user_data_base64     = base64encode(data.template_file.user_data_nodes.rendered)

  lifecycle {
    create_before_destroy = true
  }
}