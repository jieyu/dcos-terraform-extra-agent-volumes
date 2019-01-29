output "public_fqdns" {
  description = "List of Public FQDNs"
  value       = ["${aws_route53_record.instance_public.*.name}"]
}

output "private_fqdns" {
  description = "List of Private FQDNs"
  value       = ["${aws_route53_record.instance_internal.*.name}"]
}

output "private_ips" {
  description = "List of Private IPs"
  value       = ["${aws_route53_record.instance_internal.*.records}"]
}

output "public_ips" {
  description = "List of Public IPs"
  value       = ["${aws_route53_record.instance_public.*.records}"]
}
