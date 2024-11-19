terraform {
  required_version = ">= 0.13"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}


module "server" {
  for_each = var.servers

  source          = "./modules/server"
  hostname        = each.key
  memory          = each.value.memory
  vcpus           = each.value.vcpus
  cloudinit_id    = libvirt_cloudinit_disk.commoninit.id
  ssh_private_key = "/home/mdc/.ssh/id_rsa"

}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  network_config = file("${path.module}/network_config.cfg")
  user_data      = file("${path.module}/cloud_init.cfg")
}

output "vm_ips" {
  value = { for key, module in module.server : key => module.ip }
}

output "ALL_HOSTS" {
  description = "Space-separated list of all VM IP addresses"
  value       = join(" ", [for vm in module.server : vm.ip])
}
