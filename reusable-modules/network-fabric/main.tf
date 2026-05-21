resource "aws_vpc" "core_vpc" {
  cidr_block = "172.28.0.0/16"

  tags = {
    Name = "terravault-core-vpc"
  }
}

resource "aws_subnet" "ingress_segment" {
  vpc_id                  = aws_vpc.core_vpc.id
  cidr_block              = "172.28.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ingress-segment"
  }
}

resource "aws_subnet" "runtime_segment" {
  vpc_id            = aws_vpc.core_vpc.id
  cidr_block        = "172.28.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "runtime-segment"
  }
}

resource "aws_internet_gateway" "edge_gateway" {
  vpc_id = aws_vpc.core_vpc.id

  tags = {
    Name = "terravault-edge-gateway"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.core_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.edge_gateway.id
  }

  tags = {
    Name = "terravault-public-route"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.ingress_segment.id
  route_table_id = aws_route_table.public_route.id
}