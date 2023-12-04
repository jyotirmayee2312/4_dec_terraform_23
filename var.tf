# VPC variable

variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = "10.0.0.0/16"
}

# Key variable

variable "key_name" {
  description = "Name for the AWS key pair"
  type        = string
  default     = "my_key_jatin"
}

# Key file name variable

variable "key_filename" {
  description = "Filename for the local private key file"
  type        = string
  default     = "my_key_jatin.pem"
}
