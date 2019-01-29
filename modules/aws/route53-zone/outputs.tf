output "zone_id" {
  description = "ID of the Zone Created"
  value       = "${aws_route53_zone.main.zone_id}"
}
