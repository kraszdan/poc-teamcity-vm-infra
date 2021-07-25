source "file" "teamcity-windows" {
  source = "output/windows/teamcity.ova"
  target = "output/windows/export.ova"
}

build {
  sources = [
    "sources.file.teamcity-windows"
  ]

  post-processor "amazon-import" {
    region         = var.region
    s3_bucket_name = var.import_bucket
    role_name      = var.import_role
    license_type   = "BYOL"
  }
}
