/**
 * DC/OS Terraform-Ansible-Bridge (Inventory and group_vars generator)
 * ============
 * This module creates two local files that can be used by Ansible to manage a DC/OS cluster.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-ansible-bridge" {
 *   source  = "dcos-terraform/dcos-ansible-bridge/local_file"
 *   version = "~> 0.1"
 *
 *   bootstrap_ip         = "${module.dcos-infrastructure.bootstrap.public_ip}"
 *   master_ips           = ["${module.dcos-infrastructure.masters.public_ips}"]
 *   private_agent_ips    = ["${module.dcos-infrastructure.private_agents.public_ips}"]
 *   public_agent_ips     = ["${module.dcos-infrastructure.public_agents.public_ips}"]
 *
 *   bootstrap_private_ip = "${module.dcos-infrastructure.bootstrap.private_ip}"
 *   master_private_ips   = ["${module.dcos-infrastructure.masters.private_ips}"]
 * }
 *
 * module "dcos-infrastructure" {
 *   source  = "dcos-terraform/infrastructure/aws"
 *   version = "~> 0.1"
 *
 *   [...]
 *
 * }
 *```
 */
resource "local_file" "ansible_inventory" {
  filename = "./hosts"

  content = <<EOF
[bootstraps]
${var.bootstrap_ip}

[masters]
${join("\n", var.master_ips)}

[agents_private]
${join("\n", var.private_agent_ips)}

[agents_public]
${join("\n", var.public_agent_ips)}

[bootstraps:vars]
node_type=bootstrap

[masters:vars]
node_type=master
dcos_legacy_node_type_name=master

[agents_private:vars]
node_type=agent
dcos_legacy_node_type_name=slave

[agents_public:vars]
node_type=agent_public
dcos_legacy_node_type_name=slave_public

[agents:children]
agents_private
agents_public

[dcos:children]
bootstraps
masters
agents
agents_public
EOF
}

resource "local_file" "ansible_groupvars" {
  filename = "./dcos.yml"

  content = <<EOF
---
dcos:
  config:
    bootstrap_url: http://${var.bootstrap_private_ip}:8080
    exhibitor_storage_backend: static
    master_discovery: static
    master_list: ["${join("\",\"", var.master_private_ips)}"]

EOF
}