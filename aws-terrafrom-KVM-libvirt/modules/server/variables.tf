variable "hostname" {
  description = "The hostname of the server"
  type        = string
}

variable "memory" {
  description = "The amount of memory for the server"
  type        = number
}

variable "vcpus" {
  description = "The number of vCPUs for the server"
  type        = number
}

variable "cloudinit_id" {
  description = "The ID of the cloud-init resource"
  type        = string
}

variable "ssh_private_key" {
  description = "Path to the SSH private key"
  type        = string
}

