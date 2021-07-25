variable "disk_size" {
  description = "Initial disk size"
  type        = number
  default     = 40000
}

variable "cpus" {
  description = "Number of CPUs"
  type        = number
  default     = 4
}

variable "memory" {
  description = "Memory size in MB"
  type        = number
  default     = 2048
}

variable "headless" {
  description = "Whether to build in headless mode"
  type        = bool
  default     = false
}

variable "username" {
  description = "VM username"
  type        = string
  default     = "teamcity"
}

variable "password" {
  description = "VM password"
  type        = string
  default     = "teamcity"
}

variable "ssh_key" {
  description = "SSH key"
  type        = string
}
