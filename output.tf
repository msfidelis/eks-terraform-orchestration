output "message" {
      value = <<MESSAGE

    ## Bastion Host ##
    User          ec2-user
    Hostname      ${module.eks.bastion.public_ip}
    IdentityFile  ${var.aws_key_path}
    
    MESSAGE
}