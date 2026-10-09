resource "aws_vpc" "demovpc" {
  cidr_block       = "11.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-demo"
  }
}
resource "aws_subnet" "sub-a" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = "11.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}
resource "aws_subnet" "sub-b" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = "11.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demovpc.id

  tags = {
    Name = "learnigw"
  }
}

resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "learnrt"
  }
}

resource "aws_route_table_association" "demo-suba-rta" {
  subnet_id      = aws_subnet.sub-a.id
  route_table_id = aws_route_table.demo-rt.id
}
resource "aws_route_table_association" "demo-subb-rta" {
  subnet_id      = aws_subnet.sub-b.id
  route_table_id = aws_route_table.demo-rt.id
}


