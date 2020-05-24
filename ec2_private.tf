
resource "aws_instance" "web" {
  ami           = "ami-0722cc82fbed6c031"
  instance_type = "t2.micro"
subnet_id = aws_subnet.main.id
vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Public Instance"
  }
}