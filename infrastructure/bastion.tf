module "bastion" {
  source = "./modules/bastion"

  key_name              = aws_key_pair.this.key_name
  vpc_id                = aws_vpc.this.id
  subnet_id             = aws_subnet.public[0].id
  allowed_host_cidrs    = var.allowed_host_cidrs
  allowed_private_cidrs = aws_subnet.private[*].cidr_block

  common_tags = local.common_tags
}
