resource "aws_vpc" "vpc_paris" {
  cidr_block = var.cidr_paris
  tags = {
    "Name" = "VPC-PARIS-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_paris.id
  cidr_block              = var.subnets["public"]
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public-Subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_paris.id
  cidr_block        = var.subnets["private"]
  availability_zone = "eu-west-3a"
  tags = {
    "Name" = "Private-Subnet-${local.sufix}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_paris.id
  tags = {
    "Name" = "IGW-VPC-PARIS-${local.sufix}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_paris.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "Public-Route-Table-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "sg_public_instance" {
  vpc_id      = aws_vpc.vpc_paris.id
  name        = "SG-PUBLIC-INSTANCE"
  description = "Security Group for Public Instance"

  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    description = "All traffic to the internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "SG-PUBLIC-INSTANCE-${local.sufix}"
  }

}