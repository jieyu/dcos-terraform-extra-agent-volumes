/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-masters-internal/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins-internal/job/dcos-terraform/job/terraform-azurerm-lb-masters/job/master/)
 *
 * Azure LB Masters Internal
 * ============
 * This module create a load balancer for cluster internal access to masters
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "lb-masters-internal" {
 *   source  = "dcos-terraform/lb-masters-internal/azurerm"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   location            = ["North Europe"]
 *   resource_group_name = "my-resource-group"
 *   subnet_id           = "subnet/id/the/load-balancer/should/be/in"
 * }
 *```
 */

provider "azurerm" {}

module "masters-internal" {
  source  = "../../azurerm/lb"
  version = "~> 0.1.0"

  cluster_name = "${var.cluster_name}"

  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  lb_name_format = "int-%[1]s"

  providers = {
    azurerm = "azurerm"
  }

  additional_rules = [
    {
      frontend_port = 5050
    },
    {
      frontend_port = 2181
    },
    {
      frontend_port = 8181
    },
    {
      frontend_port = 8080
    },
  ]

  probe {
    port = 5050
  }

  internal  = true
  subnet_id = "${var.subnet_id}"

  tags = "${var.tags}"
}