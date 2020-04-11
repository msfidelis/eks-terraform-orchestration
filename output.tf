output "message" {
      value = <<MESSAGE

    ## Get cluster context 

    $ aws eks --region us-east-1 update-kubeconfig --name ${var.cluster_name}
    $ kubectl get all


    ## Bastion Host ##
    User          ec2-user
    Hostname      ${module.eks.bastion.public_ip}
    IdentityFile  ${var.aws_key_path}
    
    MESSAGE
}