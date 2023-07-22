resource "aws_instance" "dev" {
ami = var.ami
instance_type = var.instance_type
key_name = var.key_name
count = var.ec2_count
vpc_security_group_ids = ["$aws_default_security_group.main.id"]
subnet_id = element(var.subnets, count.index)
}