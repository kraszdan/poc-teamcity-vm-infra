output "public_ip" {
  description = "Public IP address"
  value = aws_instance.this.public_ip
}

output "private_ip" {
  description = "Private IP address"
  value = aws_instance.this.private_ip
}

output "user" {
  description = "Non-root user"
  value = "ubuntu"
}
