/**
 * GCP Forwarding Rules - DC/OS
 * ============
 * This module creates forwarding rules for DC/OS.
 *
 * *HINT* be aware you've set the proper compute_firewall rules to enable forwarding-rules health checks to access your instances. Could be done by using `terraform-dcos/compute-firewall/gcp`
 *
 * External masters load balancer
 * ------------------------------
 * This load balancer keeps an redundant entry point to the masters
 *
 * Internal masters load balancer ( not implemented yet )
 * ------------------------------
 * this load balancer is used for internal communication to masters
 *
 * External public agents load balancer
 * ------------------------------------
 * This load balancer keeps a single entry point to your public agents no matter how many you're running.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-forwarding-rules" {
 *   source  = "dcos-terraform/terraform-gcp-compute-forwarding-rule-dcos/gcp"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   masters_self_link = ["${module.masters.instances_self_link}"]
 *   public_agents_self_link = ["${module.public_agents.instances_self_link}"]
 * }
 *```
 */

module "dcos-forwarding-rule-masters" {
  source  = "../../gcp/compute-forwarding-rule-masters"
  version = "~> 0.1.0"

  cluster_name = "${var.cluster_name}"

  masters_self_link = ["${var.masters_self_link}"]
  additional_rules  = ["${var.masters_additional_rules}"]

  labels = "${var.labels}"
}

module "dcos-forwarding-rule-public-agents" {
  source  = "../../gcp/compute-forwarding-rule-public-agents"
  version = "~> 0.1.0"

  source = "../terraform-gcp-compute-forwarding-rule-public-agents"

  cluster_name = "${var.cluster_name}"

  public_agents_self_link = ["${var.public_agents_self_link}"]
  additional_rules        = ["${var.public_agents_additional_rules}"]

  labels = "${var.labels}"
}