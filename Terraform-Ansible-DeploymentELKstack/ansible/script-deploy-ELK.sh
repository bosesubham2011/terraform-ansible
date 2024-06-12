#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible -y
sudo mkdir ansible
# Your Git repository URL 
repo_url="https://github.com/bosesubham2011/terraform-ansible.git" 
 
# Directory to clone the repository into 
clone_dir="ansible" 
 
# CSV file to store the output 
csv_file="output.csv" 
 
# Clone the Git repository 
git clone "$repo_url" "$clone_dir" 
 
# Navigate into the cloned repository directory 
cd "$clone_dir/Terraform-Ansible-DeploymentELKstack/ansible/tasks" || exit 



# Run your scripts and capture the output 
ansible-playbook ./tasks/generatessl.yml 
 
# Check if the script ran successfully 
if [ $? -eq 0 ]; then 
  # Write the output to the CSV file 
  echo "$script_output" > "$csv_file" 
 
  # Print a success message 
  echo "Script executed successfully. Output saved to $csv_file" 
else 
  # Print an error message if the script failed 
  echo "Error: Script execution failed." 
fi 
