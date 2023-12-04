output "instance_ip" {
    description = "Public IP of Jump Server Instance"
   value = aws_instance.public_instance.public_ip
}

output "instance_private_ip" {
    description = "Private IP of Production Instance"
   value = aws_instance.private_instance.private_ip
}

output "vpc" {
 description = "The ID of the VPC"
 value      = aws_vpc.custom_vpc.id
}

output "public_route_table" {
 description = "The ID of the public route table"
 value      = aws_default_route_table.public_route_table.id
}

output "private_route_table" {
 description = "The ID of the private route table"
 value      = aws_route_table.private_route_table.id
}

output "eip" {
 description = "The ID of the Elastic IP"
 value      = aws_eip.nat.id
}

output "nat_gateway" {
 description = "The ID of the NAT Gateway"
 value      = aws_nat_gateway.nat.id
}

output "alb_dns_name" {
 description = "The DNS name of the ALB"
 value    = aws_lb.my_alb.dns_name
}

# Run local command after applying Terraform
#resource "null_resource" "save_outputs" {
#  provisioner "local-exec" {
#    command = <<-EOT
#      echo "Instance Public IP: ${terraform output instance_ip}" > outputs.txt
#      echo "Instance Private IP: ${terraform output instance_private_ip}" >> outputs.txt
#    EOT
#  }
#  depends_on = [aws_instance.public_instance, aws_instance.private_instance]
#}
