
# Creates a VPC 

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Create a Internet Gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Create a Public Subnets

resource "aws_subnet" "public" {
 
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 0)  # 10.0.0.0/24 , 10.0.1.0/24
  availability_zone = var.availability_zones[0]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

# Create a Private Subnets

resource "aws_subnet" "private" {
   
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8,  10)   # 10.0.0.0/16 + 8 = 10.0.0.0/24  , 10.0.10.0/24, 10.0.11.0/24 
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.project_name}-private-subnet"
  }
}

# Create a Database Subnets

resource "aws_subnet" "database" {
   
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8,  20)  # 10.0.0.0/16 + 8 = 10.0.0.0/24 , 10.0.20.0/24, 10.0.21.0/24
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.project_name}-database-subnet"
  }
}

# Create a EIP

resource "aws_eip" "nat" {
   
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }

  depends_on = [aws_internet_gateway.main]
}

# Create a NAT Gateway

resource "aws_nat_gateway" "main" {
  
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.project_name}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.main]
}

# Create a Public RouteTable

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Create a Private RouteTable

resource "aws_route_table" "private" {
 
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Route Table Associations

resource "aws_route_table_association" "public" {
 
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
 
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}