module "vpc" {
  source                 = "./modules/terraform"
  cidr                   = var.vpc_cidr
  name                   = "${var.name}-${var.environment}"
  nat_per_az             = true
  separate_db_subnets    = true
  subnet_outer_offsets   = [3, 3, 3]
  subnet_inner_offsets   = [3, 3, 3]
  transit_gateway_attach = false
  transit_gateway_id     = var.transit_gateway_id
  allow_cidrs_default    = {}
  

}
module "ec2" {
  source                 = "./modules/terraform"
  ami =  var.ami
  instance_type      = "t2.micro"
  key_pair = "demo-ems"
  subnet_id = var.subnets
  associate_public_ip_address = true

}

