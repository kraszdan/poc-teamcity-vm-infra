variable "ami_name" {
  description = "Ubuntu AMI name pattern"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}

variable "instance_type" {
  description = "Host instance type"
  type        = string
  default     = "t2.nano"
}

variable "key_name" {
  description = "Host key pair name"
  type        = string
}

variable "disk_size" {
  description = "Host disk size"
  type        = number
  default     = 10
}

variable "vpc_id" {
  description = "VPC id to run in"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to use"
  type        = string
}

variable "allowed_host_cidrs" {
  description = "Hosts allowed to connect"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_private_cidrs" {
  description = "PrivateCIDRs to be accessible"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
