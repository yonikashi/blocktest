resource "aws_route53_record" "this" {
  zone_id = "${data.aws_route53_zone.kin.zone_id}"
  name    = "${var.name}.${var.tld}"
  records = ["${aws_eip.this.public_ip}"]
  type    = "A"
  ttl     = "300"
}
