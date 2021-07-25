data "aws_ami" "this" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name]
  }

  owners = ["099720109477"]
}
