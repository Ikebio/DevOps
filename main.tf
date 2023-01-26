# create vpc
resource "aws_vpc" "Jan-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Jan vpc"
  }
}

# create internet gateway
resource "aws_internet_gateway" "Jan-gw" {
  vpc_id = aws_vpc.Jan-vpc.id

  tags = {
    Name = "Jan gw"
  }
}

#create public subnet
resource "aws_subnet" "Jan-pub-sub" {
  vpc_id     = aws_vpc.Jan-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Jan pub sub"
  }
}

#create priv subnet
resource "aws_subnet" "Jan-priv-sub" {
  vpc_id     = aws_vpc.Jan-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Jan priv sub"
  }
}

#creat pub route
resource "aws_route_table" "Jan-pub-rt" {
  vpc_id = aws_vpc.Jan-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Jan-gw.id
  }

  tags = {
    Name = "Jan pub rt"
  }
}

#creating priv rout
resource "aws_route_table" "Jan-priv-rt" {
  vpc_id = aws_vpc.Jan-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
  
  }

  tags = {
    Name = "Jan priv rt"
  }
}

#Subnet Association
resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.Jan-pub-sub.id
  route_table_id = aws_route_table.Jan-pub-rt.id
}
resource "aws_route_table_association" "priv" {
  gateway_id     = aws_subnet.Jan-priv-sub.id
  route_table_id = aws_route_table.Jan-priv-rt.id
}