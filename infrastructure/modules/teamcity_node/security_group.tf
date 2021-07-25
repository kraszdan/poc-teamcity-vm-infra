resource "aws_security_group" "this" {
  name   = var.name
  vpc_id = var.vpc_id

  ingress {
    protocol    = "TCP"
    from_port   = local.management_port
    to_port     = local.management_port
    cidr_blocks = var.allowed_cidrs
  }

  ingress {
    protocol    = "TCP"
    from_port   = 8111
    to_port     = 8111
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = var.name
  })
}
