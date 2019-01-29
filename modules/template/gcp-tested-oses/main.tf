/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-template-gcp-tested-oses/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-template-gcp-tested-oses/job/master/)
 * # Tested DC/OS OSes GCP
 *
 * This is a module that properly configures the DC/OS prerequisites for selected OSes on top of GCP.
 *
 * ## EXAMPLE
 *
 *```hcl
 * module "dcos-tested-gcp-oses" {
 *    source   = "./modules/dcos-tested-gcp-oses"
 *    os       = "${var.os}"
 * }
 *```
 */

## GCP Data Templates
#

data "template_file" "traditional_os_user" {
  #  count    = "${var.enabled == "true" ? 1 : 0 }"
  template = "$${aws_user_result}"

  vars {
    aws_user_result = "${lookup(var.traditional_default_os_user, element(split("_",var.os),0))}"
  }
}

data "template_file" "image_family" {
  #  count    = "${var.enabled == "true" ? 1 : 0 }"
  template = "$${result}"

  vars {
    result = "${element(var.os_image_version[var.os], 0)}"
  }
}

data "template_file" "image_name" {
  #  count    = "${var.enabled == "true" ? 1 : 0 }"
  template = "$${result}"

  vars {
    result = "${element(var.os_image_version[var.os], 1)}"
  }
}

# Cloud Image Instruction
data "template_file" "os-setup" {
  #  count    = "${var.enabled == "true" ? 1 : 0 }"
  template = "${file("${path.module}/platform/cloud/${var.provider}/${var.os}/setup.sh")}"
}