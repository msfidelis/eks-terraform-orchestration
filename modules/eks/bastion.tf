resource "aws_instance" "bastion" {

    ami = data.aws_ami.eks_worker.id
    instance_type = "t2.micro"

    subnet_id = var.public_subnet_1a.id
    associate_public_ip_address = true

    vpc_security_group_ids = [ 
        aws_security_group.cluster_bastion_sg.id
    ]

    key_name = var.cluster_key.key_name

  tags = {
    Name = format("%s-bastion", var.cluster_name)
  }

}

resource "aws_security_group" "cluster_bastion_sg" {
  name = format("%s-bastion-sg", var.cluster_name)

  vpc_id = var.cluster_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-bastion-sg", var.cluster_name)
  }
}