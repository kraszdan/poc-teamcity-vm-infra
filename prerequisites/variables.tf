variable "region" {
  description = "Region Terraform deploys your instance"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket" {
  description = "State S3 bucket name"
  type        = string
  default     = "teamcity-poc-infra-state"
}

variable "import_bucket" {
  description = "VM import S3 bucket name"
  type        = string
  default     = "teamcity-poc-infra-import"
}

variable "import_role" {
  description = "VM import IAM role name"
  type        = string
  default     = "vmimport"
}

locals {
  common_tags = {
    Project = "TeamCity infra PoC"
  }
}
