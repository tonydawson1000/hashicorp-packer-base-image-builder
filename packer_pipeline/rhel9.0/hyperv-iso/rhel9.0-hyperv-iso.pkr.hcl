variable "rhel_9_0_vm_name" {
  type    = string
  default = "rhel9_0_base"
}
variable "rhel_9_0_cpus" {
  type    = number
  default = 2
}
variable "rhel_9_0_memory" { 
  type    = number
  default = 2048
}
variable "rhel_9_0_output_directory" {
  type    = string
  default = "./builds"
}

variable "rhel_9_0_iso_url" {
  type    = string
  default = ""
}
variable "rhel_9_0_iso_checksum" {
  type    = string
  default = ""
}

variable "rhel_9_0_username" {
  type    = string
  default = "packer"
}
variable "rhel_9_0_password" {
  type    = string
  default = "packer"
}

variable "rhel_9_0_boot_command" {
  type    = list(string)
  default = [""]
}
variable "rhel_9_0_http_directory" {
  type    = string
  default = ""
}
variable "rhel_9_0_shutdown_command" {
  type    = string
  default = "echo 'packer' | sudo -S shutdown -P now"
}

variable "rhel_9_0_hyperv_switch_name" {
  type    = string
  default = "Default Switch"
}
variable "rhel_9_0_hyperv_generation" {
  type    = number
  default = 2
}

# https://github.com/hashicorp/packer-plugin-hyperv/releases
# https://github.com/hashicorp/packer-plugin-hyperv/blob/main/docs/builders/iso.mdx
packer {
  required_plugins {
    hyperv = {
      version = " >= 1.0.0"
      source  = "github.com/hashicorp/hyperv"
    }
  }
}

source "hyperv-iso" "rhel9_0" {
  vm_name           = var.rhel_9_0_vm_name
  cpus              = var.rhel_9_0_cpus
  memory            = var.rhel_9_0_memory
  output_directory  = var.rhel_9_0_output_directory
  
  iso_url           = var.rhel_9_0_iso_url
  iso_checksum      = var.rhel_9_0_iso_checksum

  ssh_username      = var.rhel_9_0_username
  ssh_password      = var.rhel_9_0_password
  ssh_timeout       = "30m"

  boot_command      = var.rhel_9_0_boot_command
  http_directory    = var.rhel_9_0_http_directory
  shutdown_command  = var.rhel_9_0_shutdown_command

  switch_name       = var.rhel_9_0_hyperv_switch_name
  generation        = var.rhel_9_0_hyperv_generation
}

build {
  name = "Hyper-V Builder"

  sources = ["source.hyperv-iso.rhel9_0"]
}