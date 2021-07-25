output "instance_id" {
  description = "Instance ID"
  value = aws_instance.this.id
}

output "private_ip" {
  description = "Private IP address"
  value = aws_instance.this.private_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value = aws_security_group.this.id
}
