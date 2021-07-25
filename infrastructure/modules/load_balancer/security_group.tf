resource "aws_security_group" "this" {
  name   = "teamcity-alb"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    cidr_blocks = var.allowed_host_cidrs
  }

  egress {
    protocol        = "TCP"
    from_port       = 8111
    to_port         = 8111
    security_groups = var.instance_security_group_ids
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "teamcity-alb"
  })
}
