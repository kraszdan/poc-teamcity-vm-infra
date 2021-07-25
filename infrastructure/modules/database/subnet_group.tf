resource "aws_db_subnet_group" "this" {
  name       = "teamcity-db-subnet-group"
  subnet_ids = var.subnet_ids
}
