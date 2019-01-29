output "ip_address" {
  description = "Load balancer ip address"
  value       = "${module.dcos-forwarding-rule-masters.ip_address}"
}
