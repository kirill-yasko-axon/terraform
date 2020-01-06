# General AWS configuration
variable "region" {
default = "eu-central-1"
}    

# S3 Configuration
#--------------------------------------------------------------#

variable "bucket_name" {
default = "ziqy-staging-s3-bucket"
}

#--------------------------------------------------------------#

# EC2 Configuration
#--------------------------------------------------------------#
# SSH

variable "ssh_key_name" {   
default = "sandbox-ziqy-key"
}
 
variable "public_key_path" {   
default = "~/.ssh/id_rsa.pub"
}
  
variable "private_key_path" { 
default = "~/.ssh/id_rsa"
}
 

# Instance parameters

variable "instance_name" {
default =  "ziqy-sandbox"
}

variable "amazon_machine_image" {
default =  "ami-0cc0a36f626a4fdf5"
}

variable "instance_type" {
default = "t2.micro"
}

# Storage parameters

variable "storage_size" {
default = "20"
}

# Elastic IP parameters
variable "eip_name" {
default = "sandbox_eip"
}

# Security group parameters
variable "public_ports" {
default = "[80, 443]"
}

variable "ssh_allowed_ips" { 
default = "[0.0.0.0/0]"
}
#--------------------------------------------------------------#

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "subnet_id" {
default = "subnet-e2776f9f"
}

variable "vpc_id" {
default = "vpc-c039c3aa"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443]
}
