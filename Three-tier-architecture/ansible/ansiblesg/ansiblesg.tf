variable "vpc_id"{

}

variable "project" {
  default = "america"
}
variable "env" {
  default = "production"
}




resource "aws_security_group" "ansible-sg-america" {
  vpc_id = "${var.vpc_id}"

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ansible-sg-america"
    Environment = lower(var.env)
    Project = lower(var.project)
  }
}

output "ansiblesg_id" { 
  value = "${aws_security_group.ansible-sg-america.id}"
}