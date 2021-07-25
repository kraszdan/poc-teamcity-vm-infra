resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]
}
