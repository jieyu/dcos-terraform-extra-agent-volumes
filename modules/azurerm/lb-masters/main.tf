/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-masters/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-masters/job/master/)
 *
 * Azure LB Masters
 * ============
 * This module create a load balancer to access the masters externally.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "lb-masters" {
 *   source  = "dcos-terraform/lb-masters/azurerm"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   location = ["North Europe"]
 *   resource_group_name = "my-resource-group"
 * }
 *```
 */

provider "azurerm" {}

module "masters" {
  source  = "../../azurerm/lb"
  version = "~> 0.1.0"

  cluster_name = "${var.cluster_name}"

  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  providers = {
    azurerm = "azurerm"
  }

  probe {
    port = 5050
  }

  tags = "${var.tags}"
}