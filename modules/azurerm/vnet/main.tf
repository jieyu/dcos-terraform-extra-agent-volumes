/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-vnet/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-vnet/job/master/)
 *
 * DC/OS VNET
 * ==========
 * This is an module to create a Azure VNET specially used for DC/OS
 *
 * EXAMPLE
 * -------
 *
 * ```hcl
 * module "dcos-vnet" {
 *   source  = "dcos-terraform/vnet/azurerm"
 *   version = "~> 0.1.0"
 *
 *   location            = "West US"
 *   subnet_range        = "10.32.4.0/22"
 *   resource_group_name = "test"
 *   cluster_name        = "my-cluster"
 * }
 * ```
 */

provider "azurerm" {}

# Create a virtual network in the web_servers resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.cluster_name}"
  address_space       = ["${var.subnet_range}"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"
}

resource "azurerm_subnet" "dcos" {
  name                 = "dcos"
  address_prefix       = "${var.subnet_range}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${var.resource_group_name}"
}