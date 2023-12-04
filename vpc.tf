# VPC Create

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "custom_vpc"
  }
}

# Public subnate create

resource "aws_subnet" "public_subnet" {
 vpc_id    = aws_vpc.custom_vpc.id
 cidr_block = "10.0.1.0/24"
 map_public_ip_on_launch = true
 availability_zone = "ap-south-1a"

 tags = {
   Name = "public_subnet"
 }
}

# Private subnate create

resource "aws_subnet" "private_subnet" {
 vpc_id    = aws_vpc.custom_vpc.id
 cidr_block = "10.0.2.0/24"
 availability_zone = "ap-south-1a"

 tags = {
   Name = "private_subnet"
 }
}

# Another public subnate

resource "aws_subnet" "public_subnet2" {
 vpc_id    = aws_vpc.custom_vpc.id
 cidr_block = "10.0.3.0/24"
 map_public_ip_on_launch = true
 availability_zone = "ap-south-1b"

 tags = {
  Name = "public-subnet-2"
 }
}

# Internet gateway creation.

resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.custom_vpc.id

 tags = {
  Name = "custom_igw"
 }
}

# Allocate to Elastic IP for Nat Gateway

resource "aws_eip" "nat" {
 #vpc = true
}

# NAT Gateway creation

resource "aws_nat_gateway" "nat" {
 allocation_id = aws_eip.nat.id
 subnet_id    = aws_subnet.public_subnet.id
}

# Internet Gateway attach to main route table of that VPC.

resource "aws_default_route_table" "public_route_table" {
  default_route_table_id = aws_vpc.custom_vpc.default_route_table_id

 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }

  tags = {
    Name = "Public_rt"  # Add other tags as needed
  }
}

# Create another route table for Private route.

resource "aws_route_table" "private_route_table" {
 vpc_id = aws_vpc.custom_vpc.id

 route {
   cidr_block    = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.nat.id
 }

 tags = {
   Name = "private_route_table"
 }
}

# Route table private and public subnate association. 

resource "aws_route_table_association" "public_subnet_association" {
 subnet_id     = aws_subnet.public_subnet.id
 route_table_id = aws_default_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
 subnet_id     = aws_subnet.public_subnet2.id
 route_table_id = aws_default_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
 subnet_id     = aws_subnet.private_subnet.id
 route_table_id = aws_route_table.private_route_table.id
}

