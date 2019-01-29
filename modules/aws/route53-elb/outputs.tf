output "public_fqdns" {
  description = "The alias name of the Masters ELB"
  value       = "${aws_route53_record.masters_alias.name}"
}
