output "dns_name" {
  description = "DNS Name of the master load balancer"
  value       = "${aws_lb.loadbalancer.dns_name}"
}
