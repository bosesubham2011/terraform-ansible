# terraform-ansible
This is a basic terraform implementation with ansible

# The repository has 3 sections:

# Simple-Terraform

It contains a file named main.tf which will create a basic VPC and deploy EC2 instances if ran against proper commands

terraform init<br>
terraform plan -var-file varstf.tfvars

# Three-tier-architecture

It contains code which can deploy a 3 tier architecture with RDS and ALB. The Application being on the mid tier.
It will also deploy two EC2 servers

terraform init
<br>
terraform plan

# Terraform-Ansible-DeploymentELHstack

It contains code which can deploy a three tier architecture and subsequently ansible can be used for the deployment of the ELK stack.
