variable "region" {
  description = "AWS region used to import VM images"
  type        = string
}

variable "import_bucket" {
  description = "AWS S3 bucket used to import VM images"
  type        = string
}

variable "import_role" {
  description = "AWS IAM role used to import VM images "
  type        = string
}
