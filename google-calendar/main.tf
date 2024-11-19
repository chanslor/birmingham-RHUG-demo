# main.tf

# Initialize the required providers
terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
  }
}

# Resource to execute a local script
resource "null_resource" "create_calendar_event" {
  provisioner "local-exec" {
    command = "bash create_event.sh"
  }
}

