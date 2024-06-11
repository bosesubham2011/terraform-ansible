resource "aws_subnet" "public-subnet-america-1" {
  vpc_id                  = "${aws_vpc.main-vpc-america.id}"
  cidr_block             = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-america-1"
    project = "America"
  }
}

resource "aws_subnet" "public-subnet-america-2" {
  vpc_id                  = "${aws_vpc.main-vpc-america.id}"
  cidr_block             = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-subnet-america-2"
    project = "America"
  }
}


resource "aws_subnet" "application-subnet-america-1" {
  vpc_id                  = "${aws_vpc.main-vpc-america.id}"
  cidr_block             = "${var.subnet2_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"

  tags = {
    Name = "application-subnet-america-1"
    project = "America"
  }
}

resource "aws_subnet" "application-subnet-america-2" {
  vpc_id                  = "${aws_vpc.main-vpc-america.id}"
  cidr_block             = "${var.subnet3_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"

  tags = {
    Name = "application-subnet-america-2"
    project = "America"
  }
}

resource "aws_subnet" "database-subnet-america-1" {
  vpc_id            = "${aws_vpc.main-vpc-america.id}"
  cidr_block        = "${var.subnet4_cidr}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "database-subnet-america-1"
  }
}

resource "aws_subnet" "database-subnet-america-2" {
  vpc_id            = "${aws_vpc.main-vpc-america.id}"
  cidr_block        = "${var.subnet5_cidr}"
  availability_zone = "us-east-1b"

  tags = {
    Name = "database-subnet-america-2"
    project = "America"
  }
}
