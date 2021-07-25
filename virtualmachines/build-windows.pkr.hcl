source "virtualbox-iso" "teamcity-windows" {
  guest_os_type = "Windows2016_64"
  iso_url       = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
  iso_checksum  = "3022424f777b66a698047ba1c37812026b9714c5"

  disk_size     = var.disk_size
  cpus          = var.cpus
  memory        = var.memory
  nested_virt   = true
  headless      = var.headless
  rtc_time_base = "UTC"

  floppy_files         = ["installer/autounattend.xml"]
  guest_additions_mode = "disable"
  shutdown_command     = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout     = "15m"
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--vram", "48"],
    ["modifyvm", "{{.Name}}", "--audio", "none"]
  ]

  communicator   = "winrm"
  winrm_username = var.username
  winrm_password = var.password
  winrm_timeout  = "12h"

  format           = "ova"
  output_directory = "output/windows"
  output_filename  = "teamcity"
}

build {
  sources = [
    "sources.virtualbox-iso.teamcity-windows"
  ]

  provisioner "ansible" {
    playbook_file = "provisioner/vm.yml"
    use_proxy     = false
    user          = var.username
    ansible_env_vars = [
      "OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES",
      "WINRM_PASSWORD={{.WinRMPassword}}"
    ]
    extra_arguments = [
      "--extra-vars", "ansible_winrm_scheme=http"
    ]
  }
}
