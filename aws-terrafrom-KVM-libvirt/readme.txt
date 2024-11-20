 #All my notes on making these work
 virsh list --all

#Get IP address of a system
 virsh domifaddr server01

#Start vm
 virsh start server01

#Stop vm
 virsh shutdown server01

#Start console on vm
 virsh console server01
 virsh console server1 ( CTRL + SHIFT + ]  to exit )

#with aws image
 ssh -i /tmp/id_rsa ec2-user@192.168.100.254


#Doing the actual work with passing vars:
-----------------------------------------
 terraform init
 terraform plan -var-file="hostnames.tfvars"
 terraform plan -var 'hostnames=["server01", "server02", "server03", "server04", "server05", "server06"]'
 terraform apply -var-file="hostnames.tfvars" -auto-approve

 terraform destroy -var-file="hostnames.tfvars" -auto-approve


#LOOP testing with vars
 terraform refresh -var-file="hostnames.tfvars"

#or...
 for host in $(terraform output -raw ALL_HOSTS); do
  ssh mdc@$host
done


#Random tests

for i in $ALL_HOSTS; do ping -c3 $i ; done

for i in $ALL_HOSTS; do ssh -q ec2-user@$i "uptime"; done


#Testing graphviz
terraform graph -type=plan > plan.gv
dot -Tpng plan.gv -o plan.png

terraform graph -type=plan | dot -Tpng >graph.png

#DEMO - What the files look like
tree view

project/
├── main.tf
├── terraform.tfvars
├── variables.tf
├── network_config.cfg
├── cloud_init.cfg
├── modules/
│   └── server/  <--- Base server module for creating servers
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf


#Start demo here:
 terraform init
 terraform plan
 terraform apply

#Takes about 5 minutes

#Once completed
#Test passing ENV to Ansible
 terraform output -json > terraform_output.json

 ansible-inventory -i ./terraform_inventory.py --list

 ansible-playbook -i ./terraform_inventory.py  check-httpd-playbook.yml

#Remove all the systems
 terraform destroy -var-file="hostnames.tfvars" -auto-approve


