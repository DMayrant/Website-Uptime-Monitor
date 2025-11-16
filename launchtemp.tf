resource "aws_launch_template" "ec2_launch_template" {
  name          = "ec2_launch_template"
  image_id      = "ami-0360c520857e3138f"
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.website_monitor_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = "EC2-Launch-Template"
    })
  }
}
