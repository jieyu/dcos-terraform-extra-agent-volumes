output "ip_address" {
  description = "Load balancer ip address"
  value       = "${module.dcos-forwarding-rule-public-agents.ip_address}"
}
