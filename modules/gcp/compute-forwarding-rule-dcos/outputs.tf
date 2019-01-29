output "masters_ip_address" {
  description = "IP Address of master load balancer"
  value       = "${module.dcos-forwarding-rule-masters.ip_address}"
}

output "public_agents_ip_address" {
  description = "IP Address of public agents load balancer"
  value       = "${module.dcos-forwarding-rule-public-agents.ip_address}"
}
