resource "aws_key_pair" "cluster_key" {
    key_name = format("%s-key", var.cluster_name)
    public_key = file(var.aws_key_path)
}