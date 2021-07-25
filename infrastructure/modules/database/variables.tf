variable "availability_zone" {
  description = "Place in selected availability zone"
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

variable "allowed_cidrs" {
  description = "Allowed CIDRs"
  type        = list(string)
}

variable "name" {
  description = "Database name to create in the instance"
  type        = string
  default     = "teamcity"
}

variable "username" {
  description = "Database username"
  type        = string
  default     = "teamcity"
}

variable "password" {
  description = "Database password"
  type        = string
  default     = "HwmIYFxlnYzdEeaiueV2oJ0l1eJqA8eh"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
