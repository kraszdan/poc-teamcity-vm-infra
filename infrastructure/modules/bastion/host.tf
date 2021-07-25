resource "aws_instance" "this" {
  ami                         = data.aws_ami.this.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.disk_size
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = self.public_ip
      user     = "ubuntu"
    }

    inline = [
      "sudo sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/g' /etc/ssh/sshd_config",
      "sudo sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config",
      "sudo systemctl restart ssh"
    ]
  }

  tags = merge(var.common_tags, {
    Name = "teamcity-bastion"
  })
}


