/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-private-agents/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-private-agents/job/master/)
 * # DC/OS Instances
 *
 * Creates DC/OS Private Agent intances
 *
 * ## Usage
 *
 *```hcl
 * module "pvtagts" {
 *   source = "dcos-terraform/instances/gcp"
 *   version = "~> 0.1.0"
 *
 *   num_instance                   = "${var.instances_count}"
 *   disk_size                      = "${var.gcp_instances_disk_size}"
 *   disk_type                      = "${var.gcp_instances_disktype}"
 *   region                         = "${var.gcp_region}"
 *   machine_type                   = "${var.gcp_instances_gce_type}"
 *   cluster_name                   = "${var.cluster_name}"
 *   public_ssh_key                 = "${var.gcp_ssh_key}"
 *   instances_subnetwork_name      = "${module.network.instances_subnetwork_name}"
 *   instances_targetpool_self_link = "${module.network.instances_targetpool_self_link}"
 *   customer_image                 = "${var.image}"
 *   region                         = "${var.gcp_region}"
 *   zone_list                      = "${data.google_compute_zones.available.names}"
 * }
 *```
 */

provider "google" {}

module "dcos-pvtagt-instances" {
  source  = "../../gcp/instance"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  cluster_name             = "${var.cluster_name}"
  hostname_format          = "${var.hostname_format}"
  num_instances            = "${var.num_private_agents}"
  image                    = "${var.image}"
  user_data                = "${var.user_data}"
  machine_type             = "${var.machine_type}"
  instance_subnetwork_name = "${var.private_agent_subnetwork_name}"
  ssh_user                 = "${var.ssh_user}"
  public_ssh_key           = "${var.public_ssh_key}"
  zone_list                = "${var.zone_list}"
  disk_type                = "${var.disk_type}"
  disk_size                = "${var.disk_size}"
  tags                     = "${var.tags}"
  dcos_instance_os         = "${var.dcos_instance_os}"
  dcos_version             = "${var.dcos_version}"
  scheduling_preemptible   = "${var.scheduling_preemptible}"

  labels = "${var.labels}"
}