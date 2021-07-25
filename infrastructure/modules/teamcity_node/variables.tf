variable "config" {
  description = "Node config to /etc/teamcity/config.yml"
  type = string
}

variable "name" {
  description = "Node name"
  type        = string
}

variable "distribution" {
  description = "OS distribution"
  type        = string
}

variable "ami_id" {
  description = "AMI id to be used for node"
  type        = string
}

variable "instance_type" {
  description = "Node instance type"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "Node key pair name"
  type        = string
}

variable "disk_size" {
  description = "Node disk size"
  type        = number
  default     = 40
}

variable "delete_disk_on_termination" {
  description = "Whether to delete disk on termination"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC id to run in"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to use"
  type        = string
}

variable "allowed_cidrs" {
  description = "Allowed source CIDRs"
  type        = list(string)
}

variable "bastion_host" {
  description = "Bastion host to connect through"
  type = string
}

variable "bastion_user" {
  description = "Bastion host to connect through"
  type = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

locals {
  management_port = var.distribution == "ubuntu" ? 22 : 5985
}
