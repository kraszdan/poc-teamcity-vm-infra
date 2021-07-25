resource "aws_security_group" "this" {
  name   = "teamcity-efs"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "TCP"
    from_port   = 2049
    to_port     = 2049
    security_groups = var.instance_security_group_ids
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "teamcity-efs"
  })
}
