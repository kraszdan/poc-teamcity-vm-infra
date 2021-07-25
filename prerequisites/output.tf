resource "local_file" "packer_export" {
  filename = "output/export.json"
  content = jsonencode({
    region        = var.region
    import_bucket = var.import_bucket
    import_role   = var.import_role
  })
}

resource "local_file" "terraform_backend" {
  filename = "output/backend.tfvars"
  content  = <<EOF
bucket = "${var.state_bucket}"
key    = "state"
region = "${var.region}"
EOF
}

resource "local_file" "terraform_region" {
  filename = "output/region.tfvars"
  content  = <<EOF
region = "${var.region}"
EOF
}
