resource "aws_vpc" "dev_vpc" {
  cidr_block           = "172.18.0.0/16"
  enable_dns_hostnames = true
  //default true
  enable_dns_support = true

  tags = {
    Name = "dev-vpc"
  }
}


resource "aws_subnet" "dev_public_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "172.18.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "dev-public-subnet"
  }
}




resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-public-route"
  }
}


resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.dev_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}


resource "aws_internet_gateway" "dev_internet_gateway" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-igw"
  }
}


resource "aws_route_table_association" "dev_public_association" {
  subnet_id      = aws_subnet.dev_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}