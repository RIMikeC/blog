data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami*_64-gp2"]
  }
}

resource aws_instance "blog" {
  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-c0dc22a6"
  associate_public_ip_address = "true"
  tags                        = "${var.tags}"
  key_name                    = "${aws_key_pair.keys.key_name}"
  vpc_security_group_ids      = ["sg-0cb6af1b772ad904f"]
  user_data                   = "${file("${path.module}/startblog.sh")}"
}

// also add user_data=""

resource "aws_key_pair" "keys" {
  public_key = "${file("${path.module}/test230119.pub")}"
}
