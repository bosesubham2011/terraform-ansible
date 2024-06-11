resource "aws_instance" "ansible-master-america" {
  ami = "${data.aws_ami.aws-linux.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public-subnet-america-1.id}"
  vpc_security_group_ids = ["${aws_security_group.ansible-sg-america.id}"]
  key_name               = var.ssh_key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  # User data script to install Ansible
  user_data = "${file("./Dependencies/user_data/userdata-america-ansible-master.sh")}"
}

# Creating 2nd EC2 instance in Public Subnet
resource "aws_instance" "ansible-node-america" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.application-subnet-america-1.id
  vpc_security_group_ids = [aws_security_group.ansible-sg-america.id]
  key_name               = var.ssh_key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  # User data script to install Ansible
  user_data = "${file("./Dependencies/user_data/userdata-america-ansible-node.sh")}"
}
