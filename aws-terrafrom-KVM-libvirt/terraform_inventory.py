#!/usr/bin/python3
#!/usr/bin/env python3

import json

# Load the Terraform output
with open("terraform_output.json") as f:
    data = json.load(f)

# Extract host IPs from the Terraform output
vm_ips = data.get("vm_ips", {}).get("value", {})

# Generate JSON-compatible inventory
inventory = {
    "all": {
        "hosts": list(vm_ips.values()),
        "vars": {
            "ansible_user": "ec2-user",
            "ansible_ssh_private_key_file": "/home/mdc/.ssh/id_rsa"
        }
    }
}

# Print JSON output
print(json.dumps(inventory, indent=2))

