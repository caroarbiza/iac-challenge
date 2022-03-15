/*==== The VPC ======*/
resource "aws_vpc" "iac_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "iac-vpc"
  }
}

/* Public subnet */
resource "aws_subnet" "public_subnet_iac" {
  vpc_id                  = aws_vpc.iac_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-subnet-iac"
  }

}

/* Gateway */
resource "aws_internet_gateway" "gateway_iac" {
  vpc_id = aws_vpc.iac_vpc.id
  tags = {
    Name        = "iac-gateway"
    Description = "Gateway for the web application"
  }
}

resource "aws_default_route_table" "defaultroutetable_iac" {
  default_route_table_id = aws_vpc.iac_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway_iac.id
  }
  tags = {
    Name        = "rt-iac"
    Description = "Route Table made in iac"
  }
} 


/* Security Group */
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH & HTTP inbound traffic"
  vpc_id      = aws_vpc.iac_vpc.id


  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "HTTP from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }

  ]
  egress = [
    {
      description      = "SSH & HTTP"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  tags = {
    Name = "allow_SSH_HTTP"
  }

}
