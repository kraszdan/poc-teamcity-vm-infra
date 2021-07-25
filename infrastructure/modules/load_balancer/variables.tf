variable "domain_name" {
  description = "Domain name to be used for ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC id to run in"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs to use"
  type        = list(string)
}

variable "allowed_host_cidrs" {
  description = "Hosts allowed to connect"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_ids" {
  description = "Target instance IDs"
  type        = list(string)
}

variable "instance_security_group_ids" {
  description = "Target instance Security Group IDs"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
