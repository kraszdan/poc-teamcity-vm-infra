resource "aws_alb" "this" {
  name               = "teamcity-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = merge(var.common_tags, {
    Name = "teamcity-alb"
  })
}

resource "aws_alb_target_group" "this" {
  name     = "teamcity-alb-tg"
  port     = 8111
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    port     = 8111
    protocol = "HTTP"
    path     = "/showAgreement.html"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "teamcity-alb-tg"
  })
}

resource "aws_alb_target_group_attachment" "this" {
  count = length(var.instance_ids)

  target_group_arn = aws_alb_target_group.this.arn
  target_id        = var.instance_ids[count.index]
}

resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }

  tags = merge(var.common_tags, {
    Name = "teamcity-alb-listener"
  })
}
