source "virtualbox-iso" "teamcity-ubuntu" {
  guest_os_type = "Ubuntu_64"
  iso_url       = "https://releases.ubuntu.com/20.04.2/ubuntu-20.04.2-live-server-amd64.iso"
  iso_checksum  = "sha256:d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"

  disk_size     = var.disk_size
  cpus          = var.cpus
  memory        = var.memory
  nested_virt   = true
  headless      = var.headless
  rtc_time_base = "UTC"

  http_directory       = "installer"
  guest_additions_mode = "disable"
  shutdown_command     = "sudo shutdown -P now"
  boot_wait            = "5s"
  boot_command = [
    " <wait>",
    " <wait>",
    " <wait>",
    " <wait>",
    " <wait>",
    "<esc><wait>",
    "<f6><wait>",
    "<esc><wait>",
    "<bs><bs><bs><bs>",
    " autoinstall",
    " ds=nocloud-net",
    ";s=http://{{.HTTPIP}}:{{.HTTPPort}}/",
    " ---",
    "<enter><wait>"
  ]

  ssh_username   = var.username
  ssh_password   = var.password
  ssh_agent_auth = true
  ssh_port       = 22
  ssh_timeout    = "10000s"

  format           = "ova"
  output_directory = "output/ubuntu"
  output_filename  = "teamcity"
}

build {
  sources = [
    "sources.virtualbox-iso.teamcity-ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "mkdir -p ~/.ssh",
      "echo '${var.ssh_key}' >> ~/.ssh/authorized_keys"
    ]
  }

  provisioner "ansible" {
    playbook_file = "provisioner/vm.yml"
    use_proxy     = false
    user          = var.username
    extra_arguments = [
      "-e", "ansible_become=true"
    ]
  }
}
