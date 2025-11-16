resource "aws_lb" "ALB" {
  name                       = "cloud-security-migration-lb"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.website_monitor_sg.id]
  subnets                    = aws_subnet.public_subnet[*].id
  enable_deletion_protection = false

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "alb"
  #   enabled = true
  # }

  tags = merge(local.common_tags, {
    Name = "ALB"
  })
}

# Create a target group and Health checks for the ALB
resource "aws_lb_target_group" "alb-tg" {
  name        = "instance-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
