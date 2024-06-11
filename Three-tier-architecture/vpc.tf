resource "aws_vpc" "main-vpc-america" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "main-vpc-america"
    Project = "America"
  }
}
