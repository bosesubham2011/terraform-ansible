# Creating Route Table
resource "aws_route_table" "route-america-1" {
    vpc_id = "${aws_vpc.main-vpc-america.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw-america.id}"
    }

    route {
        cidr_block = "${var.subnet2_cidr}"
        network_interface_id = "${aws_network_interface.application-networkinterface-america-1.id}"
    }

    route {
        cidr_block = "${var.subnet3_cidr}"
        network_interface_id = "${aws_network_interface.application-networkinterface-america-2.id}"
    }

    tags = {
        Name = "route-america-1"
        Project = "America"
    }
}


# Associating Route Table
resource "aws_route_table_association" "routetableassociation-america-1" {
    subnet_id = "${aws_subnet.public-subnet-america-1.id}"
    route_table_id = "${aws_route_table.route-america-1.id}"
}

# Associating Route Table
resource "aws_route_table_association" "routetableassociation-america-2" {
    subnet_id = "${aws_subnet.public-subnet-america-2.id}"
    route_table_id = "${aws_route_table.route-america-2.id}"
}


# Creating Private Network channel
resource "aws_network_interface" "application-networkinterface-america-1" {
  subnet_id = aws_subnet.application-subnet-america-1.id
}

resource "aws_network_interface" "application-networkinterface-america-2" {
  subnet_id = aws_subnet.application-subnet-america-2.id
}
