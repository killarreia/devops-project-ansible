resource "aws_key_pair" "default" {
  key_name   = "my-key-pair"
  public_key = var.public_key
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["163.116.169.78/32"] # Replace with your IP for security
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "free_tier" {
  ami           = "ami-02141377eee7defb9" # Amazon Linux 2023 AMI ID (eu-west-1). Update based on your region.
  instance_type = "t2.micro" # Free Tier eligible

  key_name               = aws_key_pair.default.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "FreeTierInstance"
  }

  root_block_device {
    volume_size = 8 # Default is 8 GB
  }
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.free_tier.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.free_tier.public_dns
}
