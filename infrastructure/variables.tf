variable "region" {
  description = "Region Terraform deploys your instance"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Availability zones to deploy into"
  type        = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
  ]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR block for management subnet"
  type        = string
  default     = "10.0.0.0/17"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.192.0/18"
}

variable "allowed_host_cidrs" {
  description = "Hosts allowed to connect to resources"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "domain_name" {
  description = "Domain name used by servers"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for connections"
  type        = string
}

variable "teamcity_ubuntu_ami_id" {
  description = "ARN of Teamcity Ubuntu AMI to be used by VMs"
  type        = string
}

variable "teamcity_windows_ami_id" {
  description = "ARN of Teamcity Windows AMI to be used by VMs"
  type        = string
}

locals {
  common_tags = {
    Project = "TeamCity infra PoC"
  }
}
