resource "aws_efs_file_system" "this" {
  creation_token = var.creation_token

  lifecycle_policy {
    transition_to_ia = var.transition_to_ia
  }

  tags = merge(var.common_tags, {
    Name = "teamcity-efs"
  })
}

resource "aws_efs_mount_target" "this" {
  count = length(var.subnet_ids)

  file_system_id = aws_efs_file_system.this.id
  subnet_id = var.subnet_ids[count.index]
  security_groups = [aws_security_group.this.id]
}
