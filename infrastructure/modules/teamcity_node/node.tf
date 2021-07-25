resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = false

  root_block_device {
    volume_size           = var.disk_size
    delete_on_termination = var.delete_disk_on_termination
  }

  tags = merge(var.common_tags, {
    Name = var.name
  })
}

resource "local_file" "node_vars" {
  filename = "output/${var.name}.yml"
  content = var.config
}

resource "null_resource" "this" {
  triggers = {
    node_instance_id = aws_instance.this.id
    local_file = local_file.node_vars.id
    config           = var.config
  }

  provisioner "local-exec" {
    working_dir = "../virtualmachines/provisioner"
    command = "./configure.sh"
    environment = {
      BASTION_USER = var.bastion_user
      BASTION_HOST = var.bastion_host
      DISTRIBUTION = var.distribution
      NODE_HOST = aws_instance.this.private_ip
      NODE_VARS = "../../infrastructure/output/${var.name}.yml"
    }
  }
}


