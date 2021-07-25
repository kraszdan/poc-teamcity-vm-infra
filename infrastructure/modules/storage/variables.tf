variable "vpc_id" {
  description = "VPC id to run in"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs to use"
  type        = list(string)
}

variable "instance_security_group_ids" {
  description = "Target instance Security Group IDs"
  type        = list(string)
}

variable "creation_token" {
  description = "Creation token used to distinguish file system instances"
  type        = string
  default     = "teamcity-efs"
}

variable "transition_to_ia" {
  description = "When to move files to IA"
  type        = string
  default     = "AFTER_30_DAYS"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
