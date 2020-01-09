# General AWS configuration
variable "region" {
default = "eu-central-1"
}    

# S3 Configuration
#--------------------------------------------------------------#

variable "bucket_name" {
default = "ziqy-sandbox-bucket-s3"
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

# RDS Configuration
#--------------------------------------------------------------#

variable "rds_storage_size" {
default =  20
}
variable "rds_max_storage_size" {
default = 100
}
variable "rds_engine" {
default = "postgres"
}
variable "rds_engine_version" {
default = "11.5"
}
variable "rds_instance_class" {
default = "db.t2.micro"
}
variable "rds_instance_name" {
default = "sandbox-rds"
}
variable "rds_default_username" {}
variable "rds_default_password" {}
#--------------------------------------------------------------#

