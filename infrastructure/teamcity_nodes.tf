module "teamcity_server_0" {
  source = "./modules/teamcity_node"

  config = <<EOF
teamcity_server_enabled:  true
teamcity_server_db_url: ${module.database.url}
teamcity_server_db_user: ${module.database.user}
teamcity_server_db_password: ${module.database.password}
teamcity_server_data_efs_enabled: true
teamcity_server_data_efs_src: "${module.storage.filesystem_id}.efs.${var.region}.amazonaws.com:/"
EOF

  name         = "teamcity-server-0"
  distribution = "ubuntu"
  ami_id       = var.teamcity_ubuntu_ami_id
  key_name     = aws_key_pair.this.key_name
  vpc_id       = aws_vpc.this.id
  subnet_id    = aws_subnet.private[0].id
  allowed_cidrs = concat(
    aws_subnet.private[*].cidr_block,
    aws_subnet.public[*].cidr_block
  )
  bastion_host = module.bastion.public_ip
  bastion_user = module.bastion.user

  common_tags = local.common_tags

  depends_on = [aws_route_table_association.private]
}

module "teamcity_agents_0" {
  source = "./modules/teamcity_node"

  config = <<EOF
teamcity_agents_count: 2
teamcity_agents_server_url: https://${var.domain_name}
EOF

  name         = "teamcity-agent-0"
  distribution = "ubuntu"
  ami_id       = var.teamcity_ubuntu_ami_id
  key_name     = aws_key_pair.this.key_name
  vpc_id       = aws_vpc.this.id
  subnet_id    = aws_subnet.private[0].id
  allowed_cidrs = concat(
    aws_subnet.private[*].cidr_block,
    aws_subnet.public[*].cidr_block
  )
  bastion_host = module.bastion.public_ip
  bastion_user = module.bastion.user

  common_tags = local.common_tags

  depends_on = [aws_route_table_association.private]
}

module "teamcity_agents_1" {
  source = "./modules/teamcity_node"

  config = <<EOF
teamcity_agents_count: 2
teamcity_agents_server_url: https://${var.domain_name}
EOF

  name         = "teamcity-agent-1"
  distribution = "windows"
  ami_id       = var.teamcity_windows_ami_id
  key_name     = aws_key_pair.this.key_name
  vpc_id       = aws_vpc.this.id
  subnet_id    = aws_subnet.private[0].id
  allowed_cidrs = concat(
    aws_subnet.private[*].cidr_block,
    aws_subnet.public[*].cidr_block
  )
  bastion_host = module.bastion.public_ip
  bastion_user = module.bastion.user

  common_tags = local.common_tags

  depends_on = [aws_route_table_association.private]
}
