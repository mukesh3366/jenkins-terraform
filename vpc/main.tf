provider "aws" {
  region     = "ap-south-1"
  
}
# Create a VPC for the region associated with the AZ
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "network-${var.infra_env}-vpc"
    Environment = var.infra_env

  }
}




