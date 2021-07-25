resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "teamcity-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "teamcity-igw"
  })
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  cidr_block = cidrsubnet(
    var.public_subnet_cidr,
    ceil(log(length(var.availability_zones), 2)),
    count.index
  )
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]

  tags = merge(local.common_tags, {
    Name = "teamcity-public-${count.index}"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, {
    Name = "teamcity-public"
  })
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_eip" "this" {
  count = length(var.availability_zones)

  tags = merge(local.common_tags, {
    Name = "teamcity-nat-eip-${count.index}"
  })
}

resource "aws_nat_gateway" "this" {
  count = length(var.availability_zones)

  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = aws_eip.this[count.index].id

  tags = merge(local.common_tags, {
    Name = "teamcity-ngw-${count.index}"
  })
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  cidr_block = cidrsubnet(
    var.private_subnet_cidr,
    ceil(log(length(var.availability_zones), 2)),
    count.index
  )
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]

  tags = merge(local.common_tags, {
    Name = "teamcity-private-${count.index}"
  })
}

resource "aws_route_table" "private" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = merge(local.common_tags, {
    Name = "teamcity-private-${count.index}"
  })
}

resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}
