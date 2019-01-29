/**
 * GCP Forwarding Rule - Masters
 * ============
 * This module creates an GCP forwarding rule for DC/OS masters. The default ports are `80` and `443`. Also a default healthcheck is applied.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-forwarding-rule-masters" {
 *   source  = "dcos-terraform/compute-forwarding-rule-masters/gcp"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   masters_self_link = [${"module.masters.instances_self_link"}]
 * }
 *```
 */

provider "google" {}

module "dcos-forwarding-rule-masters" {
  source  = "../../gcp/compute-forwarding-rule"
  version = "~> 0.1.0"

  cluster_name = "${var.cluster_name}"

  instances_self_link = ["${var.masters_self_link}"]
  name_format         = "${var.name_format}"

  additional_rules = ["${var.additional_rules}"]

  health_check {
    target = "/"
    port   = "5050"
  }

  labels = "${var.labels}"
}