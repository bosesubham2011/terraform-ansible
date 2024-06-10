variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "ssh_key_name" {}

variable "private_key_path" {}

variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet1_cidr" {
  default = "172.16.0.0/24"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}


resource "aws_vpc" "vpc-america" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = "true"
}

resource "aws_subnet" "subnet-america" {
  cidr_block = var.subnet1_cidr
  vpc_id = aws_vpc.vpc-america.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[1]
}

resource "aws_internet_gateway" "gateway-america" {
  vpc_id = aws_vpc.vpc-america.id
}

resource "aws_route_table" "route_table-america" {
  vpc_id = aws_vpc.vpc-america.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway-america.id
  }
}

resource "aws_route_table_association" "route-subnet-america" {
  subnet_id = aws_subnet.subnet-america.id
  route_table_id = aws_route_table.route_table-america.id
}

resource "aws_security_group" "sg-ansible-instance" {
  name = "ansible_sg"
  vpc_id = aws_vpc.vpc-america.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ansible-master-america" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet-america.id
  vpc_security_group_ids = [aws_security_group.sg-ansible-instance.id]
  key_name               = var.ssh_key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  # User data script to install Ansible
  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install ansible -y
  EOF
}

resource "aws_instance" "ansible-node-america" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet-america.id
  vpc_security_group_ids = [aws_security_group.sg-ansible-instance.id]
  key_name               = var.ssh_key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  # User data script to install Ansible
  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install ansible -y
  EOF
}


# Data

data "aws_ami" "aws-linux" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

