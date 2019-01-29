#----------------------------------------------------
# This creates an canonical name for the server
# Strictly speaking this is the listener for the elb
# that sits in front of the jump box
#---------------------------------------------------
#resource "aws_route53_record" "server" {
#  zone_id = "${aws_route53_zone.environment.zone_id}"
#  name    = "server"
#  ttl     = "60"
#  type    = "A"
#  records = ["${aws_eip.blog_server.public_ip}"]
#}
#
#resource "aws_route53_zone" "environment" {
#  name = "${var.environment}.${var.project_name}.ri-tech.io"
#
#  tags {
#    owner           = "mikec"
#  }
#}
