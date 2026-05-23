provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "app_sg" {
  name = "taskmanagerEC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.micro"

  key_name = "devops"

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "docker-server"
  }
}

output "server_ip" {
  value = aws_instance.server.public_ip
}
output "instance_id" {
  value = aws_instance.server.id
}
