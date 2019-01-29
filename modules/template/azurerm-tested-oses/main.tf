/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-template-azurerm-tested-oses/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-template-azurerm-tested-oses/job/master/)
 *
 * # Azure Tested OSes
 * This module returns for an given OS the Azure Image as well as its default user and the prerequisits script
 *
 * ## EXAMPLE
 *
 * ```hcl
 * module "dcos-tested-oses" {
 *   source  = "terraform-dcos/tested-oses/azurerm"
 *   version = "~> 0.1"
 *
 *   os = "centos_7.3"
 *   region = "West US"
 * }
 * ```
 */

## Azure Data Templates
#

data "template_file" "traditional_os_user" {
  template = "$${aws_user_result}"

  vars {
    aws_user_result = "${lookup(var.traditional_default_os_user, element(split("_",var.os),0))}"
  }
}

data "template_file" "azure_offer" {
  template = "$${result}"

  vars {
    result = "${element(var.azure_os_image_version[format("%s",var.os)], 0)}"
  }
}

data "template_file" "azure_publisher" {
  template = "$${result}"

  vars {
    result = "${element(var.azure_os_image_version[format("%s",var.os)], 1)}"
  }
}

data "template_file" "azure_sku" {
  template = "$${result}"

  vars {
    result = "${element(var.azure_os_image_version[format("%s",var.os)], 2)}"
  }
}

data "template_file" "azure_version" {
  template = "$${result}"

  vars {
    result = "${element(var.azure_os_image_version[format("%s",var.os)], 3)}"
  }
}

# Cloud Image Instruction
data "template_file" "os-setup" {
  template = "${file("${path.module}/platform/cloud/${var.provider}/${var.os}/setup.sh")}"
}