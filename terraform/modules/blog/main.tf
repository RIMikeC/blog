data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami*_64-gp2"]
  }
}

resource "aws_lb" "nlb" {
  name               = "blog-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = "${var.subnet_list}"

  enable_deletion_protection = true

  tags = {
    owner = "mikec"
  }
}

resource "aws_launch_configuration" "blog_launch_conf" {
  name                 = "blog_launch_template"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_instance_profile.name}"
  image_id             = "${data.aws_ami.ami.id}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.keys.key_name}"
  security_groups      = ["sg-0cb6af1b772ad904f"]
  user_data            = "${file("${path.module}/startblog.sh")}"

  enable_monitoring = "true"
}

resource "aws_autoscaling_group" "blog_asg" {
  name                 = "blog asg"
  min_size             = "1"
  max_size             = "2"
  launch_configuration = "${aws_launch_configuration.blog_launch_conf.name}"
  health_check_type    = "EC2"
  desired_capacity     = "1"
  vpc_zone_identifier  = ["${var.subnet_list}"]
}

resource "aws_key_pair" "keys" {
  public_key = "${file("${path.module}/test230119.pub")}"
}

# resource aws_instance "blog" {
#   ami                         = "${data.aws_ami.ami.id}"
#   instance_type               = "t2.micro"
#   subnet_id                   = "subnet-c0dc22a6"
#   associate_public_ip_address = "true"
#   tags                        = "${var.tags}"
#   key_name                    = "${aws_key_pair.keys.key_name}"
#   vpc_security_group_ids      = ["sg-0cb6af1b772ad904f"]
#   user_data                   = "${file("${path.module}/startblog.sh")}"
#   iam_instance_profile        = "${aws_iam_instance_profile.ec2_instance_profile.name}"
# }
