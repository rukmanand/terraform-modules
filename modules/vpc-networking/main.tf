
provider "aws" {
  region = var.vpc_region
}

resource "aws_vpc" "example-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "dedicated"
  tags = var.vpc_tags
}

resource "aws_subnet" "private-example-subnets" {
  count = length(var.vpc_azs)
  vpc_id     = aws_vpc.example-vpc.id
  cidr_block = element(var.vpc_private_subnets, count.index)

  tags = {
    Name = "private-example-subnets"
  }
}

resource "aws_subnet" "public-example-subnets" {
  count = length(var.vpc_azs)
  vpc_id     = aws_vpc.example-vpc.id
  cidr_block = element(var.vpc_public_subnets, count.index)

  tags = {
    Name = "public-example-subnets"
  }
}

resource "aws_internet_gateway" "example-igw" {
  vpc_id = aws_vpc.example-vpc.id
}

resource "aws_route_table" "example-public_rt" {
  vpc_id = aws_vpc.example-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example-igw.id
  }
  tags = {
    Name = "example-public_rt"
  }
}

resource "aws_route_table_association" "example-rt-association" {
  count = length(aws_subnet.public-example-subnets)
  subnet_id      = element(aws_subnet.public-example-subnets.*.id,count.index)
  route_table_id = aws_route_table.example-public_rt.id
}

resource "aws_nat_gateway" "example-ngw" {  
  count = length(aws_subnet.public-example-subnets)
  allocation_id = element(aws_eip.nat.*.id,count.index)
  subnet_id = aws_subnet.public-example-subnets[count.index].id

  tags = {
    Name = "example-ngw"
  }

  depends_on = [aws_internet_gateway.example-igw]
}

resource "aws_eip" "nat" {
  vpc = true
  count = length(aws_subnet.public-example-subnets)
}