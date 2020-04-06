variable "aws_region" {
  description = "AWS Region for the VPC"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Cluster name"
  default     = "k8s-demo"
}

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.15"
}

variable "nodes_instances_sizes" {
  default = [
      "t3.large", 
      "t3a.large"
  ]
}

variable "spot_maximum_price" {
  default = "0.12"
}

