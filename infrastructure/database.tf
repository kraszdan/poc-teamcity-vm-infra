module "database" {
  source = "./modules/database"

  availability_zone = var.availability_zones[0]
  vpc_id            = aws_vpc.this.id
  subnet_ids        = aws_subnet.private[*].id
  allowed_cidrs     = aws_subnet.private[*].cidr_block

  common_tags = local.common_tags
}
