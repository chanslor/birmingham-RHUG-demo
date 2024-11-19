resource "libvirt_volume" "vm_disk" {
  name     = "${var.hostname}-disk"
  pool     = "default"
  source   = "/var/lib/libvirt/images/amazon/al2023-kvm-2023.5.20240916.0-kernel-6.1-x86_64.xfs.gpt.qcow2"
  format   = "qcow2"
}

resource "libvirt_domain" "vm" {
  name   = var.hostname
  memory = var.memory
  vcpu   = var.vcpus

  cpu {
    mode = "host-passthrough"
  }

  firmware = "/usr/share/OVMF/OVMF_CODE_4M.fd"
  nvram {
    file = "/var/lib/libvirt/qemu/nvram/${var.hostname}_VARS.fd"
  }

  boot_device {
    dev = ["cdrom", "hd"]
  }

  disk {
    volume_id = libvirt_volume.vm_disk.id
    scsi      = true
  }

  cloudinit = var.cloudinit_id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "none"
  }

  #provisioner "local-exec" {
  #  command = "virsh start ${self.name}"
  #  when    = "destroy" # Ensure VM starts if it is recreated
  #}

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${var.hostname}",
      "sudo uname -a"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.ssh_private_key)
      host        = self.network_interface.0.addresses[0]
    }
  }

  provisioner "local-exec" {
      command = <<EOT
      ansible-playbook -i '${self.network_interface.0.addresses[0]},' \
        --private-key=${var.ssh_private_key} -u ec2-user playbook.yml
    EOT
  }


}

