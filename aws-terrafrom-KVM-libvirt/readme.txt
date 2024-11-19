 virsh list --all

#Get IP address
 virsh domifaddr aap11emc6

 virsh start control
 virsh shutdown control

 virsh console control

 ssh -i /tmp/id_rsa ec2-user@192.168.100.254


 terraform init
 terraform plan -var-file="hostnames.tfvars"
 terraform plan -var 'hostnames=["server01", "server02", "server03", "server04", "server05", "server06"]'
 terraform apply -var-file="hostnames.tfvars" -auto-approve


#LOOP
 terraform refresh -var-file="hostnames.tfvars"

 for host in $(terraform output -raw ALL_HOSTS); do
  ssh mdc@$host
done



for i in $ALL_HOSTS; do ping -c3 $i ; done

for i in $ALL_HOSTS; do ssh -q ec2-user@$i "uptime"; done



virsh list --all
virsh domifaddr aap11emc6

terraform destroy -var-file="hostnames.tfvars" -auto-approve

sudo systemctl disable amazon-ssm-agent

terraform graph -type=plan > plan.gv
dot -Tpng plan.gv -o plan.png


terraform graph -type=plan | dot -Tpng >graph.png


project/
├── main.tf
├── terraform.tfvars
├── variables.tf
├── network_config.cfg
├── cloud_init.cfg
├── modules/
│   └── server/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf

 virsh console server1 ( CTRL + SHIFT + ]  to exit )

 terraform init
 terraform plan -var-file="hostnames.tfvars"

 terraform output -json > terraform_output.json

 ansible-inventory -i ./terraform_inventory.py --list

 ansible-playbook -i ./terraform_inventory.py  check-httpd-playbook.yml

 terraform destroy -var-file="hostnames.tfvars" -auto-approve


