
resource "aws_key_pair" "ssh-key" {
  key_name   = var.ssh_key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2-instance" {
  ami           = var.amazon_machine_image
  instance_type = var.instance_type
  key_name      = var.ssh_key_name
  vpc_security_group_ids = var.vpc_security_group_ids  
  subnet_id = var.subnet_id   

  root_block_device {
    volume_type = "gp2"
    volume_size = var.storage_size
  }

  tags = {
    Name = var.instance_name
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
  vpc_id      = var.vpc_id
 
  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    
    content {
    from_port = port.value
    to_port = port.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

 
  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["217.25.198.73/32"]

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
