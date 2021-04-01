resource "aws_instance" "web" {
  ami                         = var.ubuntu_ami
  instance_type               = var.instance_type
  key_name                    = var.key
  subnet_id                   = var.pub_sub1_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  user_data                   = file(var.userdata)

  tags = {
    Name = "${var.env}-elasticsearch"
  }
}