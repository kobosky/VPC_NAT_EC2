#create a vpc
resource "aws_vpc" "Prod-rock-VPC" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = "Prod-rock-VPC"
  }
}

#Public subnet 1
resource "aws_subnet" "test-public-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.test-public-sub1-cidr_block
  availability_zone = "eu-west-2a"
  
  tags = {
    Name = "test-public-sub1"
  }
}

#Public subnet 2
resource "aws_subnet" "test-public-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.test-public-sub2-cidr_block
  availability_zone = "eu-west-2b"
  
  tags = {
    Name = "test-public-sub2"
  }
}

#Private subnet 1
resource "aws_subnet" "test-priv-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.test-priv-sub1-cidr_block
  availability_zone = "eu-west-2c"

  tags = {
    Name = "test-priv-sub1"
  }
}

#Private subnet 2
resource "aws_subnet" "test-priv-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id 
  cidr_block = var.test-priv-sub2-cidr_block
  availability_zone = "eu-west-2a"

  tags = {
    Name = "test-priv-sub2"
  }
}

#Public route route table
resource "aws_route_table" "test-pub-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id 
  tags = {
    Name = "test-pub-route-table"
  }
}

# Create Private Route Table 1 and Add Route Through Nat Gateway 1
# terraform aws create route table
resource "aws_route_table" "test-priv-route-table" {
  vpc_id            = aws_vpc.Prod-rock-VPC.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.test-Nat-gateway-1.id
  }

  tags   = {
    Name = "test-priv-route-table"
  }
}

resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.Prod-rock-VPC.id 

  tags = {
    Name = "test-igw"
  }
}

resource "aws_route" "test-igw-association" {
  route_table_id            = aws_route_table.test-pub-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.test-igw.id
}

resource "aws_route_table_association" "public_route_1_association" {
  subnet_id      = aws_subnet.test-public-sub1.id
  route_table_id = aws_route_table.test-pub-route-table.id
}

resource "aws_route_table_association" "public_route_2_association" {
  subnet_id      = aws_subnet.test-public-sub2.id
  route_table_id = aws_route_table.test-pub-route-table.id
}

resource "aws_route_table_association" "private_route_1_association" {
  subnet_id      = aws_subnet.test-priv-sub1.id
  route_table_id = aws_route_table.test-priv-route-table.id
}

resource "aws_route_table_association" "private_route_2_association" {
  subnet_id      = aws_subnet.test-priv-sub2.id
  route_table_id = aws_route_table.test-priv-route-table.id
}

# Allocate Elastic IP Address (EIP 1)
# terraform aws allocate elastic ip
resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc    = true

  tags   = {
    Name = "EIP 1"
  }
}

# Create Nat Gateway 1 in Public Subnet 1
# terraform create aws nat gateway
resource "aws_nat_gateway" "test-Nat-gateway-1" {
  allocation_id = aws_eip.eip-for-nat-gateway-1.id
  subnet_id     = aws_subnet.test-public-sub1.id

  tags   = {
    Name = "Nat Gateway Public Subnet 1"
  }
}
