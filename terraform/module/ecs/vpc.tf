#vpc, az, subnet, internet_gateway,route/route_table
data "aws_availability_zones" "az" {
    state = "available"
}


resource "aws_vpc" "vpc" {
    //name = "${var.ecs_name}_vpc"
    cidr_block = "10.32.0.0/16"
    tags                 = var.ecr_tags
  
}
resource "aws_subnet" "subnet_public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 2 + count.index)
    count = 2
    availability_zone = data.aws_availability_zones.az.names[count.index]
    map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_private" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8,count.index)
    count = 2
    availability_zone = data.aws_availability_zones.az.names[count.index]
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.vpc.id
    #The VPC ID to create in 
}

 resource "aws_route" "route" {
    #route the traffic, define the destination
    route_table_id = aws_vpc.vpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
   
 }

 resource "aws_route_table" "private_route_table" {
    count = 2
    vpc_id = aws_vpc.vpc.id
 }

 resource "aws_route_table_association" "private_route_table_ass" {
    count = 2   
    subnet_id = element(aws_subnet.subnet_private.*.id, count.index)
    route_table_id = element(aws_route_table.private_route_table.*.id, count.index) 
 }