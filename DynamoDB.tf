resource "aws_dynamodb_table" "uptime_table" {
  name         = var.dynamodb_table_name
  billing_mode = var.dynamodb_billing_mode

  hash_key  = "url"
  range_key = "timestamp"

  attribute {
    name = "url"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.enable_dynamodb_pitr
  }

  server_side_encryption {
    enabled = var.enable_dynamodb_server_side_encryption
  }

  tags = {
    Project = "Website-Uptime-Monitor"
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_endpoint_type = "Gateway"


  tags = merge(local.common_tags, {
    Name = "DynamoDB VPC Endpoint"
  
  })
  }

# Associate VPC endpoint with private route tables
resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  count = length(aws_route_table.private)

  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
  route_table_id  = aws_route_table.private.id

}