/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-public-agents/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-public-agents/job/master/)
 * Azure DC/OS Public Agent Instances
 * ==================================
 *
 * This module creates typical public agent instances
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 *module "dcos-public-agent-instances" {
 *  source  = "dcos-terraform/public-agents/azure"
 *  version = "~> 0.1.0"
 *
 *  subnet_id = "myid"
 *  security_group_ids = ["sg-12345678"]"
 *  public_ssh_key = "~/.ssh/id_rsa.pub"
 *
 *  num_public_agents = "2"
 *  ...
 *}
 *```
 */

provider "azurerm" {}

module "dcos-public-agent-instances" {
  source  = "../../azurerm/instance"
  version = "~> 0.1.0"

  providers = {
    azurerm = "azurerm"
  }

  num                          = "${var.num_public_agents}"
  location                     = "${var.location}"
  name_prefix                  = "${var.name_prefix}"
  vm_size                      = "${var.vm_size}"
  dcos_version                 = "${var.dcos_version}"
  dcos_instance_os             = "${var.dcos_instance_os}"
  ssh_private_key_filename     = "${var.ssh_private_key_filename}"
  image                        = "${var.image}"
  disk_type                    = "${var.disk_type}"
  disk_size                    = "${var.disk_size}"
  resource_group_name          = "${var.resource_group_name}"
  network_security_group_id    = "${var.network_security_group_id}"
  custom_data                  = "${var.custom_data}"
  admin_username               = "${var.admin_username}"
  ssh_public_key               = "${var.ssh_public_key}"
  tags                         = "${var.tags}"
  hostname_format              = "${var.hostname_format}"
  private_backend_address_pool = ["${var.private_backend_address_pool}"]
  public_backend_address_pool  = ["${var.public_backend_address_pool}"]
  subnet_id                    = "${var.subnet_id}"
}