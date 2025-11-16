resource "aws_eip" "NAT" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "ipv4_NAT" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = merge(local.common_tags, {
    name = "NAT-Gateway"
  })
}