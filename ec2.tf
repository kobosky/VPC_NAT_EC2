resource "aws_instance" "Test-serve-1" {
  ami           = var.ami_id       #Amazon Ubuntu AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.test-priv-sub1.id
  key_name      = var.key_name
  security_groups = [aws_security_group.Test-sec-group.id]
  associate_public_ip_address = false
  tags = {
    Name = "Test-serve-1"
  }
}

resource "aws_instance" "Test-serve-2" {
  ami           = var.ami_id      #Amazon Ubuntu AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.test-public-sub1.id
  key_name      = var.key_name
  security_groups = [aws_security_group.Test-sec-group.id]
  associate_public_ip_address = true
  tags = {
  Name = "Test-serve-2"
  }
}

resource "aws_security_group" "Test-sec-group" {
  vpc_id      = aws_vpc.Prod-rock-VPC.id

ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
