resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(local.subnet_list[0])
  cidr_block              = local.subnet_list[0][count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index + var.skip_az)
  map_public_ip_on_launch = true

  tags = {
      Name        = "public.${var.name}"
      Environment = var.environment
    }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "public.${var.name}"
    Environment = var.environment
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route" "public_tgw" {
  count                  = length(var.transit_gateway_routes)
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = tostring(var.transit_gateway_routes[count.index].destination_cidr_block)
  transit_gateway_id     = var.transit_gateway_id
}



resource "aws_route_table_association" "public" {
  count          = length(local.subnet_list[0])
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}