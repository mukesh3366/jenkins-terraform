#public security group

resource "aws_security_group" "sg_public" {
  name        = "network-${var.infra_env}-public-sg"
  description = "public internet access"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "network-${var.infra_env}-public-sg"
    Role        = "public"
    Environment = var.infra_env
   #security_groups = var.aws_security_group_public 
  }
}

  resource "aws_security_group_rule" "public_out" {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.sg_public.id
  }
 
  resource "aws_security_group_rule" "public_in_ssh" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.sg_public.id
  }
  resource "aws_security_group_rule" "public_in_http" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.sg_public.id
  }



#private security group

resource "aws_security_group" "sg_private" {
  name        = "network-${var.infra_env}-private-sg"
  description = "Private internet access"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name        = "network-${var.infra_env}-private-sg"
    Role        = "private"
    Environment = var.infra_env
    #security_groups = var.aws_security_group_private
  }
} 
  resource "aws_security_group_rule" "private_out" {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.sg_private.id
  }
  resource "aws_security_group_rule" "private_in" {
    type        = "ingress"
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc.cidr_block]

    security_group_id = aws_security_group.sg_private.id
  }
 