output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_public_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.public :
    subnet.id => subnet.cidr_block
  }
}
output "vpc_private_subnets" {
  # Result is a map of subnet id to cidr block, e.g.
  # { "subnet_1234" => "10.0.1.0/4", ...}
  value = {
    for subnet in aws_subnet.private :
    subnet.id => subnet.cidr_block
  }
}

output "subnet_id" {
  value = [for subnet in aws_subnet.private :
    subnet.id  ] 
} 
output "subnet_id_pub" {
  value = [for subnet in aws_subnet.public :
    subnet.id ] 
  } 


output "security_group_sg_public" {
  value = aws_security_group.sg_public.id
}


output "security_group_sg_private" {
  value = aws_security_group.sg_private.id
} 
