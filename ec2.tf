resource "aws_key_pair" "dev_auth" {
  key_name   = var.key_name
  public_key = file("~/.ssh/${var.key_file}")
}

resource "aws_instance" "dev_instance" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = var.intance_type
  key_name               = aws_key_pair.dev_auth.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_https.id, aws_security_group.allow_http.id]
  subnet_id              = aws_subnet.dev_public_subnet.id
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 8
  }


  tags = {
    Name = "Ubuntu server"
  }
}