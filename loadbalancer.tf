resource "aws_lb" "my_alb" {
 name              = "my-alb"
 internal          = false
 load_balancer_type = "application"
 security_groups   = [aws_security_group.my_security_group.id]
 subnets           = [aws_subnet.public_subnet.id, aws_subnet.public_subnet2.id]
}
