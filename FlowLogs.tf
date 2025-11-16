resource "aws_flow_log" "vpc_flow_log_to_s3" {
  log_destination      = aws_s3_bucket.website_log_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL" # Can be ACCEPT, REJECT, or ALL
  vpc_id               = aws_vpc.main_vpc.id

  tags = merge(local.common_tags, {
    Name = "VPC FlowLogs"
 
  })

}