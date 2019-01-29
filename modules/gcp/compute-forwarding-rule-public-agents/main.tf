/**
 * GCP Forwarding Rule - Public Agents
 * ============
 * This module creates an GCP forwarding rule for DC/OS public agents.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-forwarding-rule-public-agents" {
 *   source  = "dcos-terraform/compute-forwarding-rule-public-agents/gcp"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   public_agents_self_link = [${"module.public_agents.instances_self_link"}]
 * }
 *```
 */

provider "google" {}

module "dcos-forwarding-rule-public-agents" {
  source  = "../../gcp/compute-forwarding-rule"
  version = "~> 0.1.0"

  cluster_name = "${var.cluster_name}"

  instances_self_link = ["${var.public_agents_self_link}"]
  name_format         = "${var.name_format}"

  additional_rules = ["${var.additional_rules}"]

  health_check {
    target = "/_haproxy_health_check"
    port   = "9090"
  }

  labels = "${var.labels}"
}