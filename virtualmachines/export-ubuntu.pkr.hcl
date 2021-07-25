source "file" "teamcity-ubuntu" {
  source = "output/ubuntu/teamcity.ova"
  target = "output/ubuntu/export.ova"
}

build {
  sources = [
    "sources.file.teamcity-ubuntu"
  ]

  post-processor "amazon-import" {
    region         = var.region
    s3_bucket_name = var.import_bucket
    role_name      = var.import_role
    license_type   = "BYOL"
  }
}
