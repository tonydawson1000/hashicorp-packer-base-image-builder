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

# https://github.com/hashicorp/packer-plugin-qemu/releases
# https://github.com/hashicorp/packer-plugin-qemu/blob/main/docs/builders/qemu.mdx
packer {
  required_plugins {
    qemu = {
      version = " >= 1.0.4"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "rhel9_0" {
  vm_name           = var.rhel_9_0_vm_name
  cpus              = var.rhel_9_0_cpus
  memory            = var.rhel_9_0_memory

  iso_url           = var.rhel_9_0_iso_url
  iso_checksum      = var.rhel_9_0_iso_checksum

  ssh_username      = var.rhel_9_0_username
  ssh_password      = var.rhel_9_0_password
  ssh_timeout       = "30m"

  boot_command      = var.rhel_9_0_boot_command
  http_directory    = var.rhel_9_0_http_directory
  shutdown_command  = var.rhel_9_0_shutdown_command

  qemu_binary       = "/usr/libexec/qemu-kvm"
  accelerator       = "kvm"
  format            = "qcow2"
  net_device        = "virtio-net"
  headless          = true

  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  disk_interface   = "virtio"
  disk_size        = "40000"
}

build {
  name = "KVM / QEMU Builder"

  sources = ["source.qemu.rhel9_0"]
}