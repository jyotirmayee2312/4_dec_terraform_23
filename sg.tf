resource "aws_security_group" "my_security_group" {
 name       = "my_security_group"
 description = "Allow inbound traffic on ports 80, 443, and 22"
 vpc_id     = aws_vpc.custom_vpc.id

 ingress {
  from_port  = 80
  to_port    = 80
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  from_port  = 443
  to_port    = 443
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  from_port  = 22
  to_port    = 22
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }

 tags = {
  Name = "my_security_group"
 }
}

resource "aws_security_group" "win_security_group" {
 name       = "win_security_group"
 description = "Allow inbound traffic on ports 3389"
 vpc_id     = aws_vpc.custom_vpc.id

 ingress {
  from_port  = 3389
  to_port    = 3389
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }

  tags = {
  Name = "win_security_group"
 }
}
