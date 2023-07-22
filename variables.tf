variable "cidr" {
  default = "10.0.0.0/16"
}

variable "name" {
  default = "Terraform"
}

variable "nat_per_az" {
  default = false
}

variable "subnet_outer_offsets" {
  type        = list(number)
  default     = [ 2,4,8]
}

variable "subnet_inner_offsets" {
  type        = list(number)
  default     = [ 2,4,8 ]
}

locals {
  nat_count = var.nat_per_az ? length(local.subnet_list[0]) : 1
}


variable "environment" {
  description = "Setup the environment name of the infra resource belongs to"
  type        = string
  default     = "dev"
}


variable "separate_db_subnets" {
    type    = bool
    default = true
  
}

variable "transit_gateway_attach" {
  description = "Flag to indicate transit gateway attachment"
  type        = bool
  default     = false  # Provide a default value or change it based on your requirements
}

variable "transit_gateway_routes" {
  description = "List of transit gateway routes"
  type        = list(object({
    destination_cidr_block = string
    transit_gateway_id     = string
  }))
  default     = [
    {
      destination_cidr_block = "0.0.0.0/0"
      transit_gateway_id     = "value"
    }
  ]  # Provide a default value or change it based on your requirements
}



variable "transit_gateway_id" {
  description = "ID of the transit gateway"
  type        = string
}


variable "allow_cidrs_default" {
  type    = map(string)
  default = {
    cidr_block = "10.1.0.0/16"
  }
}

variable "skip_az" {
  type    = number
  default = 6
}

variable "subnets" {
  type = list
  default = [ "aws_subnet.public.*.id, aws_subnet.private.*.id , aws_subnet.database.*.id "]
  
}
variable "ami" {
   type = string
   default = "value"
    
  
}
