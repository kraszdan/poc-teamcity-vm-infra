resource "aws_db_instance" "this" {
  identifier             = "teamcity-db"
  allocated_storage      = 20
  max_allocated_storage  = 40
  engine                 = "postgres"
  engine_version         = "13.3"
  instance_class         = "db.t3.micro"
  availability_zone      = var.availability_zone
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  name                   = var.name
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true

  tags = merge(var.common_tags, {
    Name = "teamcity-db"
  })
}
