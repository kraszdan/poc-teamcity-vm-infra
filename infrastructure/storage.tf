module "storage" {
  source = "./modules/storage"

  vpc_id                      = aws_vpc.this.id
  subnet_ids                  = aws_subnet.private[*].id
  instance_security_group_ids = [module.teamcity_server_0.security_group_id]
}
