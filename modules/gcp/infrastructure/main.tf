/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-infrastructure/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-infrastructure/job/master/)
 *
 * # DC/OS GCP Infrastucture
 *
 * This module creates typical DS/OS infrastructure in GCP.
 *
 * ## EXAMPLE
 *
 * ```hcl
 * module "dcos-infrastructure" {
 *   source  = "dcos-terraform/infrastructure/gcp"
 *   version = "~> 0.1.0"
 *
 *   infra_public_ssh_key_path = "~/.ssh/id_rsa.pub"
 *
 *   num_masters = "3"
 *   num_private_agents = "2"
 *   num_public_agents = "1"
 * }
 * ```
 */

data "null_data_source" "lb_rules" {
  count = "${length(var.public_agents_additional_ports)}"

  inputs = {
    port_range            = "${element(var.public_agents_additional_ports, count.index)}"
    load_balancing_scheme = "EXTERNAL"
    ip_protocol           = "TCP"
  }
}

provider "google" {}

data "google_compute_zones" "available" {}

module "network" {
  source  = "../../gcp/network"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  master_cidr_range = "${var.master_cidr_range}"
  agent_cidr_range  = "${var.agent_cidr_range}"
  cluster_name      = "${var.cluster_name}"
}

module "compute-firewall" {
  source  = "../../gcp/compute-firewall"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  cluster_name                   = "${var.cluster_name}"
  network                        = "${module.network.self_link}"
  admin_ips                      = ["${var.admin_ips}"]
  internal_subnets               = ["${var.master_cidr_range}", "${var.agent_cidr_range}"]
  public_agents_additional_ports = ["${var.public_agents_additional_ports}"]
}

module "dcos-forwarding-rules" {
  source  = "../../gcp/compute-forwarding-rule-dcos"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  cluster_name                   = "${var.cluster_name}"
  masters_self_link              = ["${module.masters.instances_self_link}"]
  public_agents_self_link        = ["${module.public_agents.instances_self_link}"]
  public_agents_additional_rules = ["${data.null_data_source.lb_rules.*.outputs}"]

  labels = "${var.labels}"
}

module "bootstrap" {
  source  = "../../gcp/bootstrap"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  disk_size                 = "${coalesce(var.bootstrap_disk_size, var.infra_disk_size)}"
  disk_type                 = "${coalesce(var.bootstrap_disk_type, var.infra_disk_type)}"
  machine_type              = "${coalesce(var.bootstrap_machine_type, var.infra_machine_type)}"
  cluster_name              = "${var.cluster_name}"
  public_ssh_key            = "${coalesce(var.bootstrap_public_ssh_key_path, var.infra_public_ssh_key_path)}"
  ssh_user                  = "${coalesce(var.bootstrap_ssh_user, var.infra_ssh_user)}"
  bootstrap_subnetwork_name = "${module.network.agent_subnetwork_name}"
  image                     = "${var.bootstrap_image}"
  dcos_instance_os          = "${coalesce(var.bootstrap_dcos_instance_os, var.infra_dcos_instance_os)}"

  # Determine if we need to force a particular region
  zone_list    = "${data.google_compute_zones.available.names}"
  dcos_version = "${var.dcos_version}"
  tags         = "${var.tags}"
  labels       = "${var.labels}"
}

module "masters" {
  source  = "../../gcp/masters"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  num_masters            = "${var.num_masters}"
  disk_size              = "${coalesce(var.master_disk_size, var.infra_disk_size)}"
  disk_type              = "${coalesce(var.master_disk_type, var.infra_disk_type)}"
  machine_type           = "${coalesce(var.master_machine_type, var.infra_machine_type)}"
  cluster_name           = "${var.cluster_name}"
  public_ssh_key         = "${coalesce(var.master_public_ssh_key_path, var.infra_public_ssh_key_path)}"
  ssh_user               = "${coalesce(var.master_ssh_user, var.infra_ssh_user)}"
  master_subnetwork_name = "${module.network.master_subnetwork_name}"
  image                  = "${var.master_image}"
  dcos_instance_os       = "${coalesce(var.master_dcos_instance_os, var.infra_dcos_instance_os)}"

  # Determine if we need to force a particular region
  zone_list    = "${data.google_compute_zones.available.names}"
  dcos_version = "${var.dcos_version}"
  tags         = "${var.tags}"
  labels       = "${var.labels}"
}

module "private_agents" {
  source  = "../../gcp/private-agents"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  num_private_agents            = "${var.num_private_agents}"
  disk_size                     = "${coalesce(var.private_agent_disk_size, var.infra_disk_size)}"
  disk_type                     = "${coalesce(var.private_agent_disk_type, var.infra_disk_type)}"
  machine_type                  = "${coalesce(var.private_agent_machine_type, var.infra_machine_type)}"
  cluster_name                  = "${var.cluster_name}"
  public_ssh_key                = "${coalesce(var.private_agent_public_ssh_key_path, var.infra_public_ssh_key_path)}"
  ssh_user                      = "${coalesce(var.private_agent_ssh_user, var.infra_ssh_user)}"
  private_agent_subnetwork_name = "${module.network.agent_subnetwork_name}"
  image                         = "${var.private_agent_image}"
  dcos_instance_os              = "${coalesce(var.private_agent_dcos_instance_os, var.infra_dcos_instance_os)}"

  # Determine if we need to force a particular region
  zone_list    = "${data.google_compute_zones.available.names}"
  dcos_version = "${var.dcos_version}"
  tags         = "${var.tags}"
  labels       = "${var.labels}"
}

module "public_agents" {
  source  = "../../gcp/public-agents"
  version = "~> 0.1.0"

  providers = {
    google = "google"
  }

  num_public_agents            = "${var.num_public_agents}"
  disk_size                    = "${coalesce(var.public_agent_disk_size, var.infra_disk_size)}"
  disk_type                    = "${coalesce(var.public_agent_disk_type, var.infra_disk_type)}"
  machine_type                 = "${coalesce(var.public_agent_machine_type, var.infra_machine_type)}"
  cluster_name                 = "${var.cluster_name}"
  public_ssh_key               = "${coalesce(var.public_agent_public_ssh_key_path, var.infra_public_ssh_key_path)}"
  ssh_user                     = "${coalesce(var.public_agent_ssh_user, var.infra_ssh_user)}"
  public_agent_subnetwork_name = "${module.network.agent_subnetwork_name}"
  image                        = "${var.public_agent_image}"
  dcos_instance_os             = "${coalesce(var.public_agent_dcos_instance_os, var.infra_dcos_instance_os)}"

  # Determine if we need to force a particular region
  zone_list    = "${data.google_compute_zones.available.names}"
  dcos_version = "${var.dcos_version}"
  tags         = "${var.tags}"
  labels       = "${var.labels}"
}