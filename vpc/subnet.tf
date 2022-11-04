# Create 1 public subnets for each AZ within the regional VPC
resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key


  # 2,048 IP addresses each
  #cidrsubnet(prefix, newbits, netnum) 
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)


  tags = {
    Name        = "network-${var.infra_env}-public-subnet"
    Role        = "public"
    Environment = var.infra_env
    Subnet      = "${each.key}-${each.value}"
  }
}

# Create 1 private subnets for each AZ within the regional VPC
resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key

  # 2,048 IP addresses each
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

  tags = {
    Name        = "network-${var.infra_env}-private-subnet"
    Role        = "private"
    Environment = var.infra_env
    Subnet      = "${each.key}-${each.value}"
  }
}