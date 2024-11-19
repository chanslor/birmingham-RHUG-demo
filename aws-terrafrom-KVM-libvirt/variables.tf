variable "servers" {
  description = "Map of servers with their configurations"
  type        = map(object({
    memory = number
    vcpus  = number
  }))
}

variable "hostnames" {
  description = "List of hostnames to create (if needed elsewhere)"
  type        = list(string)
  default     = [] # Optional default, or you can remove it if mandatory
}



variable "memory" {
  description = "Memory size in MB"
  type        = number
  default     = 2048
}

variable "vcpus" {
  description = "Number of vCPUs"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

