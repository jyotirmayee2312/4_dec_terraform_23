# Target Group creation.

resource "aws_lb_target_group" "target_group" {
 name   = "my-target-group"
 port   = 80
 protocol = "HTTP"
 vpc_id = aws_vpc.custom_vpc.id
}

# Attachment of instance to target group.

resource "aws_lb_target_group_attachment" "target_group_attachment" {
 target_group_arn = aws_lb_target_group.target_group.arn
 target_id     = aws_instance.private_instance.id
 port          = 80
}

# Target group attached to Load Balancer

resource "aws_lb_listener" "front_end" {
 load_balancer_arn = aws_lb.my_alb.arn
 port             = "80"
 protocol         = "HTTP"

 default_action {
  type            = "forward"
  target_group_arn = aws_lb_target_group.target_group.arn
 }
}
