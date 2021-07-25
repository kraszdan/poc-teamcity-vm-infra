module "load_balancer" {
  source = "./modules/load_balancer"

  domain_name = var.domain_name
  vpc_id      = aws_vpc.this.id
  subnet_ids  = aws_subnet.public[*].id
  allowed_host_cidrs = concat(
    [for ip in aws_nat_gateway.this[*].public_ip : "${ip}/32"],
    var.allowed_host_cidrs
  )
  instance_ids                = [module.teamcity_server_0.instance_id]
  instance_security_group_ids = [module.teamcity_server_0.security_group_id]

  common_tags = local.common_tags
}
