output "bootstrap.ssh_user" {
  description = "Bootstrap node SSH User"
  value       = "${module.bootstrap.ssh_user}"
}

output "bootstrap.prereq_id" {
  description = "Returns the ID of the prereq script (if image are not used)"
  value       = "${module.bootstrap.prereq_id}"
}

output "masters.ssh_user" {
  description = "Deployed masters agent SSH user"
  value       = "${module.masters.ssh_user}"
}

output "forwarding_rules.masters" {
  description = "Master Forwarding Rules"
  value       = "${module.dcos-forwarding-rules.masters_ip_address}"
}

output "forwarding_rules.public_agents" {
  description = "Public Agent Forwarding Rules"
  value       = "${module.dcos-forwarding-rules.public_agents_ip_address}"
}

output "masters.prereq_id" {
  description = "Returns the ID of the prereq script for masters (if user_data or ami are not used)"
  value       = "${module.masters.prereq_id}"
}

output "private_agents.ssh_user" {
  description = "Deployed private agent SSH user"
  value       = "${module.private_agents.ssh_user}"
}

output "private_agents.prereq_id" {
  description = "Returns the ID of the prereq script for private agents (if image are not used)"
  value       = "${module.private_agents.prereq_id}"
}

output "public_agents.ssh_user" {
  description = "Deployed public agent SSH user"
  value       = "${module.public_agents.ssh_user}"
}

output "public_agents.prereq_id" {
  description = "Returns the ID of the prereq script for public agents (if image are not used)"
  value       = "${module.public_agents.prereq_id}"
}

output "bootstrap.private_ip" {
  description = "Private IP of the bootstrap instance"
  value       = "${module.bootstrap.private_ip}"
}

output "bootstrap.public_ip" {
  description = "Public IP of the bootstrap instance"
  value       = "${module.bootstrap.public_ip}"
}

output "masters.public_ips" {
  description = "Master instances public IPs"
  value       = "${module.masters.public_ips}"
}

output "masters.private_ips" {
  description = "Master instances private IPs"
  value       = "${module.masters.private_ips}"
}

output "private_agents.public_ips" {
  description = "Private Agent public IPs"
  value       = "${module.private_agents.public_ips}"
}

output "private_agents.private_ips" {
  description = "Private Agent instances private IPs"
  value       = "${module.private_agents.private_ips}"
}

output "public_agents.public_ips" {
  description = "Public Agent public IPs"
  value       = "${module.public_agents.public_ips}"
}

output "public_agents.private_ips" {
  description = "Public Agent instances private IPs"
  value       = "${module.public_agents.private_ips}"
}
