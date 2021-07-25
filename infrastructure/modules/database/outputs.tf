output "url" {
  description = "Database URL"
  value = "jdbc:postgresql://${aws_db_instance.this.endpoint}/${aws_db_instance.this.name}"
}

output "user" {
  description = "Database user"
  value = aws_db_instance.this.username
}

output "password" {
  description = "Database password"
  value = aws_db_instance.this.password
}
