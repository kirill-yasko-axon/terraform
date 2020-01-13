resource "aws_db_instance" "sandbox" {
  allocated_storage      = var.rds_storage_size
  max_allocated_storage  = var.rds_max_storage_size
  storage_type           = "gp2"
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  name                   = var.rds_instance_name
  username               = var.rds_default_username
  password               = var.rds_default_password
  vpc_security_group_ids = [aws_security_group.rds-sandbox-security-group.id]
}

resource "aws_security_group" "rds-sandbox-security-group" {
  name = "rds-z11qyTEST-security-group"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
