resource "aws_security_group" "rds-sg-america" {
  name        = "rds-sg-america"
  description = "Allow inbound traffic from application layer"
  vpc_id      = aws_vpc.main-vpc-america.id

  ingress {
    description     = "Allow traffic from application layer"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.demosg.id]
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg-america"
    Project = "America"
  }
}