output "admin_username" {
  description = "SSH User"
  value       = "${module.dcos-public-agent-instances.admin_username}"
}

output "private_ips" {
  description = "List of private ip addresses created by this module"
  value       = ["${module.dcos-public-agent-instances.private_ips}"]
}

output "public_ips" {
  description = "List of public ip addresses created by this module"
  value       = ["${module.dcos-public-agent-instances.public_ips}"]
}

output "prereq_id" {
  description = "Prereq id used for dependency"
  value       = "${module.dcos-public-agent-instances.prereq_id}"
}
