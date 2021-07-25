resource "aws_key_pair" "this" {
  key_name   = "teamcity-key-pair"
  public_key = var.ssh_public_key

  tags = merge(local.common_tags, {
    Name = "teamcity-key-pair"
  })
}
