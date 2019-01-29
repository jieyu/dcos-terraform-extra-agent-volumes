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
 *    source   = "dcos-terraform/tested-oses/gcp"
 *    os       = "centos_7.3"
 * }
 *```
 */

locals {
  os_name    = "${element(split("_", var.os),0)}"
  os_version = "${element(split("_", var.os),1)}"

  os_special_version_script = {
    centos = ["7.3"]
    coreos = []
    rhel   = []
  }

  user         = "${lookup(var.traditional_default_os_user, local.os_name)}"
  image_family = "${element(var.os_image_version[var.os], 0)}"
  image_name   = "${element(var.os_image_version[var.os], 1)}"
  script       = "${file("${path.module}/scripts/${local.os_name}/${contains(local.os_special_version_script[local.os_name], local.os_version) ? local.os_version : "setup"}.sh")}"
}