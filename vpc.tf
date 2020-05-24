#VPC Creation
resource "aws_vpc" "main" {
  cidr_block       = "10.50.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Testing"
  }
}

#Subnet creation

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.50.60.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Private-Subnet"
  }
}

resource "aws_subnet" "main2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.50.70.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Public-Subnet"
  }
}

#Internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}



# Route Table

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Publc RT"
  }
}

# Route Table Association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main2.id
  route_table_id = aws_route_table.r.id
}

# Nat Gateway


resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "gw1" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main.id

  tags = {
    Name = "gw NAT"
  }
}


