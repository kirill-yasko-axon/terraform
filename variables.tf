# General AWS configuration
variable "region" {}

# EC2 Configuration
#--------------------------------------------------------------#
# SSH
variable "ssh_key_name" {}
variable "public_key_path" {}
variable "private_key_path" {}

# Instance parameters
variable "instance_name" {}
variable "amazon_machine_image" {}
variable "instance_type" {}
# Storage parameters
variable "storage_size" {}

# Elastic IP parameters
variable "eip_name" {}

# Security group parameters
variable "public_ports" {}
variable "ssh_allowed_ips" {}
#--------------------------------------------------------------#


# S3 Configuration
#--------------------------------------------------------------#

variable "bucket_name" {}
variable "canned_acl" {}

#--------------------------------------------------------------#

# RDS Configuration
#--------------------------------------------------------------#

variable "rds_storage_size" {}
variable "rds_max_storage_size" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_instance_name" {}
variable "rds_default_username" {}
variable "rds_default_password" {}

#--------------------------------------------------------------#
