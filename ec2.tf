
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

