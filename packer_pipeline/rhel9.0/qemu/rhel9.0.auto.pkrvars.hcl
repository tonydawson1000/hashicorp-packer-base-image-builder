# https://github.com/hashicorp/packer/issues/9822

rhel_9_0_vm_name          = "rhel9_0_base"
rhel_9_0_cpus             = 2
rhel_9_0_memory           = 2048

# TODO : Get a Valid Download link (UserId and AuthCode) for RHEL
#rhel_9_0_iso_url      = "https://access.cdn.redhat.com/content/origin/files/sha256/a3/a387f3230acf87ee38707ee90d3c88f44d7bf579e6325492f562f0f1f9449e89/rhel-baseos-9.0-x86_64-dvd.iso?user=<ENTER-USER-ID-HERE>&_auth_=<ENTER-AUTH-CODE-HERE>"
rhel_9_0_iso_url      = "https://access.cdn.redhat.com/content/origin/files/sha256/a3/a387f3230acf87ee38707ee90d3c88f44d7bf579e6325492f562f0f1f9449e89/rhel-baseos-9.0-x86_64-dvd.iso?user=0c1b41c3cfdea59f5bef0187d4f164ca&_auth_=1655216206_055fb6322ba0e4bd9322236cfd4f8485"
rhel_9_0_iso_checksum = "a387f3230acf87ee38707ee90d3c88f44d7bf579e6325492f562f0f1f9449e89"

#rhel_9_0_iso_url      ="https://developers.redhat.com/content-gateway/file/rhel-8.5-x86_64-dvd.iso"

rhel_9_0_username     = "packer"
rhel_9_0_password     = "packer"

rhel_9_0_boot_command = [
  "c",
  "linuxefi /images/pxeboot/vmlinuz inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rhel9.0-ks.cfg<enter>",
  "initrdefi /images/pxeboot/initrd.img<enter> boot<enter>"
]

rhel_9_0_http_directory   = "./http/"
rhel_9_0_shutdown_command = "echo 'packer' | sudo -S shutdown -P now"