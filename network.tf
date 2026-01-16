# 1. The Virtual Private Cloud (The Land)
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "My-Project-VPC"
  }
}

# 2. The Internet Gateway (The Front Door)
# This lets the VPC talk to the internet.
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# 3. The Public Subnet (The Guest Room)
# Resources here CAN talk to the internet.
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Public-Subnet"
  }
}

# 4. The Private Subnet (The Vault)
# Resources here CANNOT be reached directly from the internet.
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private-Subnet"
  }
}

# 5. Routing (Giving Directions)
# This tells the Public Subnet: "To get to the internet, go through the Gateway."
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}