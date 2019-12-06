# General AWS configuration
region = "eu-west-1"

# EC2 Configuration
#--------------------------------------------------------------#
# SSH
ssh_key_name     = "sandbox-deploy-key" # SSH key that will be created to access ec2 instance
public_key_path  = "~/.ssh/id_rsa.pub"  # Key will be added to authorized keys on instance
private_key_path = "~/.ssh/id_rsa"      # Key will be used to pre-setup instance after creation

# Instance parameters
instance_name        = "sandbox"
amazon_machine_image = "ami-02df9ea15c1778c9c" # Image witch will be installed on the instance
instance_type        = "t2.micro"

# Storage parameters
storage_size = "20" # In GiBs

# Elastic IP parameters
eip_name = "sandbox_eip"

# Security group parameters
public_ports    = [80, 443]
ssh_allowed_ips = ["217.25.198.73/32"]
#--------------------------------------------------------------#


# S3 Configuration
#--------------------------------------------------------------#

bucket_name = "sandbox-bucket"
canned_acl  = "private" # ACL that will be applied https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl

#--------------------------------------------------------------#

# RDS Configuration
#--------------------------------------------------------------#

rds_storage_size     = 20
rds_max_storage_size = 100
rds_engine           = "postgresql"
rds_engine_version   = "11.5-R1"
rds_instance_class   = "db.t2.micro"
rds_instance_name    = "sandbox"
rds_default_username = "username"
rds_default_password = "password"

#--------------------------------------------------------------#
