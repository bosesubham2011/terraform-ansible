resource "aws_internet_gateway" "igw-america" {
  vpc_id = "${aws_vpc.main-vpc-america.id}"
  tags = {
    Name = "web-sg-america"
    Project = "America"
  }
}