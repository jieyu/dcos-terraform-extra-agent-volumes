/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-dcos/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-dcos/job/master/)
 *
 * Azure LB DC/OS
 * ============
 * This module creates three load balancers for DC/OS.
 *
 * External masters load balancer
 * ------------------------------
 * This load balancer keeps an redundant entry point to the masters
 *
 * Internal masters load balancer
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
 * module "lb-dcos" {
 *   source  = "dcos-terraform/lb-dcos/azurerm"
 *   version = "~> 0.1"
 *
 *   cluster_name = "production"
 *
 *   location                       = ["North Europe"]
 *   resource_group_name            = "my-resource-group"
 *   subnet_id                      = "subnet/id/the/load-balancer/should/be/in"
 *   public_agents_additional_rules = [{ frontend_port = 8080 }]
 * }
 *```
 */

module "masters" {
  source              = "../../azurerm/lb-masters"
  version             = "~> 0.1.0"
  cluster_name        = "${var.cluster_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags = "${var.tags}"
}

module "masters-internal" {
  source              = "../../azurerm/lb-masters-internal"
  version             = "~> 0.1.0"
  cluster_name        = "${var.cluster_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${var.subnet_id}"

  tags = "${var.tags}"
}

module "public-agents" {
  source              = "../../azurerm/lb-public-agents"
  version             = "~> 0.1.0"
  cluster_name        = "${var.cluster_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  additional_rules    = "${var.public_agents_additional_rules}"

  tags = "${var.tags}"
}