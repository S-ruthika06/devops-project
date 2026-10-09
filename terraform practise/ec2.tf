resource "aws_instance" "ec2-1" {
  ami= "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  key_name      = "sjce-keypair"
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  subnet_id = aws_subnet.sub-a.id
  user_data              = local.user_data
  tags = {
    Name = "devops-ec2-az-a"
    name = "sjce-demo"
    team="sjce-devops"
  }
}
resource "aws_instance" "ec2-2" {
  ami= "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  key_name      = "sjce-keypair"
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  subnet_id = aws_subnet.sub-b.id
  user_data              = local.user_data
  tags = {
    Name = "devops-ec2-az-b"
    name = "sjce-demo"
    team="sjce-devops"
  }
}
resource "aws_security_group" "demo-sg" {
  name        = "learn-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.demovpc.id

  tags = {
    Name = "learn-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}  
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}   
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
locals {
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y ca-certificates curl gnupg lsb-release
              sudo mkdir -p /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update -y
              sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              EOF
}
