output "name_servers" {
  value = module.load_balancer.name_servers
}

output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "database_url" {
  value = module.database.url
}

output "teamcity_server_0_private_ip" {
  value = module.teamcity_server_0.private_ip
}

output "teamcity_agents_0_private_ip" {
  value = module.teamcity_agents_0.private_ip
}

output "teamcity_agents_1_private_ip" {
  value = module.teamcity_agents_1.private_ip
}
