# Terraform provider

provider "aws" {
  region = "ap-south-1"
}

# For key generation algorithm and .pem file

resource "tls_private_key" "pk" {
 algorithm = "RSA"
 rsa_bits = 4096
}

resource "aws_key_pair" "kp" {
 key_name  = var.key_name  # Give your key name
 public_key = tls_private_key.pk.public_key_openssh
}

# Save .pem file to local system.

resource "local_file" "private_key" {
 content = tls_private_key.pk.private_key_pem
 filename = "${path.module}/${var.key_filename}"
}

# For Instance create

resource "aws_instance" "public_instance" {
 ami       = "ami-064607abed305477a" # Plese select your ami id.
 instance_type = "t2.micro"
 key_name  = aws_key_pair.kp.key_name
 vpc_security_group_ids = ["${aws_security_group.win_security_group.id}"]
 subnet_id = aws_subnet.public_subnet.id

  tags = {
 Name = "jump_instance"
 }
}

resource "aws_instance" "private_instance" {
 ami       = "ami-0287a05f0ef0e9d9a" # Plese select your ami id.
 instance_type = "t2.micro"
 key_name  = aws_key_pair.kp.key_name
 vpc_security_group_ids = ["${aws_security_group.my_security_group.id}"] 
 subnet_id = aws_subnet.private_subnet.id

# User data for ubuntu. Change your as per requirement.

 user_data = <<-EOF
            #!/bin/bash
            sudo apt update -y
            sudo apt install -y apache2
            sudo systemctl start apache2
            sudo systemctl enable apache2
            sudo mkdir /var/www/html/jatin
            sudo touch /var/www/html/jatin/index.html
            echo "Hello, World!" | sudo tee /var/www/html/jatin/index.html
            sudo sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/jatin|g' /etc/apache2/sites-available/000-default.conf
            sudo systemctl restart apache2
            EOF

 tags = {
 Name = "private_instance"
 }
}


