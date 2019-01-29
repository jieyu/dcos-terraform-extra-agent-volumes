/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb/job/master/)
 *
 * Azure LB
 * ============
 * The module creates Load Balancers on AzureRM
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-lbs" {
 *   source  = "dcos-terraform/lb/azurerm"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   location = "North Europe"
 *   resource_group_name = "my-resource-group"
 *   additional_rules = [{
 *      frontend_port = 8080
 *      backend_port  = 80
 *   }]
 * }
 *```
 */

provider "azurerm" {}

locals {
  lb_name     = "${format(var.lb_name_format,var.cluster_name, var.location)}"
  merged_tags = "${merge(var.tags, map("Name", local.lb_name),
                                   map("Cluster", var.cluster_name))}"

  default_rules = [
    {
      frontend_port           = 80
      idle_timeout_in_minutes = 4
      protocol                = "Tcp"
    },
    {
      frontend_port           = 443
      idle_timeout_in_minutes = 4
      protocol                = "Tcp"
    },
  ]

  final_rules = ["${coalescelist(var.rules, concat(local.default_rules,var.additional_rules))}"]
}

resource "azurerm_public_ip" "public_ip" {
  count                        = "${var.internal ? 0 : 1}"
  name                         = "${local.lb_name}-ip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "dynamic"
  domain_name_label            = "${local.lb_name}-ip"

  tags = "${local.merged_tags}"
}

# Front End Load Balancer
resource "azurerm_lb" "load_balancer" {
  name                = "${local.lb_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  frontend_ip_configuration {
    name                          = "${local.lb_name}-public-ip-config"
    public_ip_address_id          = "${var.internal ? "" : element(concat(azurerm_public_ip.public_ip.*.id,list("")),0)}"
    private_ip_address_allocation = "dynamic"
    subnet_id                     = "${var.internal ? var.subnet_id : ""}"
  }

  tags = "${local.merged_tags}"
}

# Back End Address Pool for Public and Private Loadbalancers
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = "${local.lb_name}-public_backend_address_pool"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.load_balancer.id}"
}

# Load Balancer Rule
resource "azurerm_lb_rule" "load_balancer_rule" {
  count               = "${length(local.final_rules)}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.load_balancer.id}"

  name                    = "load-balancer-rule-${lookup(local.final_rules[count.index], "frontend_port")}"
  protocol                = "${lookup(local.final_rules[count.index], "protocol", "Tcp")}"
  frontend_port           = "${lookup(local.final_rules[count.index], "frontend_port")}"
  backend_port            = "${lookup(local.final_rules[count.index], "backend_port", lookup(local.final_rules[count.index], "frontend_port"))}"
  idle_timeout_in_minutes = "${lookup(local.final_rules[count.index], "idle_timeout_in_minutes", 4)}"

  frontend_ip_configuration_name = "${local.lb_name}-public-ip-config"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.backend_pool.id}"
  probe_id                       = "${azurerm_lb_probe.load_balancer_http_probe.id}"
  depends_on                     = ["azurerm_lb_probe.load_balancer_http_probe"]
}

resource "azurerm_lb_probe" "load_balancer_http_probe" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.load_balancer.id}"
  name                = "${local.lb_name}-probe"

  port                = "${lookup(var.probe, "port", 80)}"
  protocol            = "${lookup(var.probe, "protocol", "TCP")}"
  request_path        = "${lookup(var.probe, "request_path", "")}"
  interval_in_seconds = "${lookup(var.probe, "interval_in_seconds", 30)}"
  number_of_probes    = "${lookup(var.probe, "number_of_probes", 2)}"
}