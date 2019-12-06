provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_key_pair" "ssh-key" {
  key_name   = var.ssh_key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2-instance" {
  ami           = var.amazon_machine_image
  instance_type = var.instance_type
  key_name      = var.ssh_key_name

  root_block_device {
    volume_type = "gp2"
    volume_size = var.storage_size
  }

  tags = {
    name = var.instance_name
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.ip

    provisioner "remote-exec" {
      inline = [
        "sudo fallocate -l 2G /swapfile",
        "sudo chmod 600 /swapfile",
        "sudo mkswap /swapfile",
        "sudo swapon /swapfile",
        "echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab",
        "free -h"
      ]

    }

  }
}

resource "aws_eip" "elastic-ip" {
  vpc               = true
  instance          = aws_instance.ec2-instance.id
  depends_on        = [aws_instance.ec2-instance]
  network_interface = aws_instance.ec2-instance.primary_network_interface_id

}

resource "aws_security_group" "security-group" {
  name = "sandbox-security-group"

  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_ips

  }

  dynamic "ingress" {
    for_each = var.public_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_network_interface_sg_attachment" "sandbox-security-group" {
  security_group_id    = aws_security_group.security-group.id
  network_interface_id = aws_instance.ec2-instance.primary_network_interface_id
}