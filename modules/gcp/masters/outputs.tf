output "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
  value       = "${var.num_masters}"
}

output "name_prefix" {
  description = "Cluster Name"
  value       = "${var.cluster_name}"
}

output "machine_type" {
  description = "Instance Type"
  value       = "${var.machine_type}"
}

output "zone_list" {
  description = "Element by zone list"
  value       = ["${var.zone_list}"]
}

output "image" {
  description = "Source image to boot from"
  value       = "${var.image}"
}

output "disk_type" {
  description = "Disk Type to Leverage The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional)"
  value       = "${var.disk_type}"
}

output "disk_size" {
  description = "Disk Size in GB"
  value       = "${var.disk_size}"
}

output "master_subnetwork_name" {
  description = "Master Subnetwork Name"
  value       = "${var.master_subnetwork_name}"
}

output "user_data" {
  description = "User data to be used on these instances (cloud-init)"
  value       = "${var.user_data}"
}

output "ssh_user" {
  description = "SSH User"
  value       = "${module.dcos-master-instances.ssh_user}"
}

output "public_ssh_key" {
  description = "SSH Public Key"
  value       = "${var.public_ssh_key}"
}

output "private_ips" {
  description = "List of private ip addresses created by this module"
  value       = ["${module.dcos-master-instances.private_ips}"]
}

output "public_ips" {
  description = "List of public ip addresses created by this module"
  value       = ["${module.dcos-master-instances.public_ips}"]
}

output "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  value       = "${var.dcos_instance_os}"
}

output "instances_self_link" {
  description = "List of instance self links"
  value       = ["${module.dcos-master-instances.instances_self_link}"]
}

output "prereq_id" {
  description = "Prereq id used for dependency"
  value       = "${module.dcos-master-instances.prereq_id}"
}
