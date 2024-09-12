# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "${var.environment}-${var.product}-vpc"
  }
}

# Create a public subnet in AZ-a
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.azs[0]  # Availability zone ap-south-1a

  tags = {
    Name = "${var.environment}-${var.product}-public-subnet-a"
  }
}

# Create a private subnet in AZ-a
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.azs[0]  # Availability zone ap-south-1a

  tags = {
    Name = "${var.environment}-${var.product}-private-subnet-a"
  }
}

# Create a public subnet in AZ-b
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.azs[1]  # Availability zone ap-south-1b

  tags = {
    Name = "${var.environment}-${var.product}-public-subnet-b"
  }
}

# Create a private subnet in AZ-b
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.azs[1]  # Availability zone ap-south-1b

  tags = {
    Name = "${var.environment}-${var.product}-private-subnet-b"
  }
}

# Create an internet gateway for public access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-${var.product}-igw"
  }
}

# Create a public route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-${var.product}-public-route-table"
  }
}

# Associate the public route table with public subnets
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# Create a private route table (no internet access)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-${var.product}-private-route-table"
  }
}

# Associate the private route table with private subnets
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
/*
# (Optional) Create a NAT Gateway in the public subnet for internet access for private instances
resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "${var.environment}-${var.product}-nat-gateway"
  }
}

# Add a route for the NAT Gateway to allow private subnets to access the internet
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
*/