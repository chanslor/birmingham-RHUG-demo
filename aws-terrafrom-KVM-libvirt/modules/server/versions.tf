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

