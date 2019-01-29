[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-public-agents/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-public-agents/job/master/)
# DC/OS Instances

Creates DC/OS Public Agent intances

## Usage

```hcl
module "pubagts" {
  source = "dcos-terraform/instances/gcp"
  version = "~> 0.1.0"

  num_instance                   = "${var.instances_count}"
  disk_size                      = "${var.gcp_instances_disk_size}"
  disk_type                      = "${var.gcp_instances_disktype}"
  region                         = "${var.gcp_region}"
  machine_type                   = "${var.gcp_instances_gce_type}"
  cluster_name                   = "${var.cluster_name}"
  public_ssh_key                 = "${var.gcp_ssh_key}"
  instances_subnetwork_name      = "${module.network.instances_subnetwork_name}"
  instances_targetpool_self_link = "${module.network.instances_targetpool_self_link}"
  customer_image                 = "${var.image}"
  region                         = "${var.gcp_region}"
  zone_list                      = "${data.google_compute_zones.available.names}"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| dcos_instance_os | Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `centos_7.4` | no |
| dcos_version | Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list. | string | - | yes |
| disk_size | Disk Size in GB | string | - | yes |
| disk_type | Disk Type to Leverage The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional) | string | - | yes |
| hostname_format | Format the hostname inputs are index+1, region, cluster_name | string | `%[3]s-publicagent%[1]d-%[2]s` | no |
| image | Source image to boot from | string | - | yes |
| labels | Add custom labels to all resources | map | `<map>` | no |
| machine_type | Instance Type | string | - | yes |
| num_public_agents | Specify the amount of public agents. These agents will host marathon-lb and edgelb | string | - | yes |
| public_agent_subnetwork_name | Instance Subnetwork Name | string | - | yes |
| public_ssh_key | SSH Public Key | string | - | yes |
| scheduling_preemptible | Deploy instance with preemptible scheduling. (bool) | string | `false` | no |
| ssh_user | SSH User | string | - | yes |
| tags | Add custom tags to all resources | list | `<list>` | no |
| user_data | User data to be used on these instances (cloud-init) | string | `` | no |
| zone_list | Element by zone list | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| dcos_instance_os | Operating system to use. Instead of using your own AMI you could use a provided OS. |
| disk_size | Disk Size in GB |
| disk_type | Disk Type to Leverage The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional) |
| image | Source image to boot from |
| instances_self_link | List of instance self links |
| machine_type | Instance Type |
| name_prefix | Cluster Name |
| num_public_agents | Specify the amount of public agents. These agents will host marathon-lb and edgelb |
| prereq_id | Prereq id used for dependency |
| private_ips | List of private ip addresses created by this module |
| public_agent_subnetwork_name | Instance Subnetwork Name |
| public_ips | List of public ip addresses created by this module |
| public_ssh_key | SSH Public Key |
| scheduling_preemptible | Deploy instance with preemptible scheduling. (bool) |
| ssh_user | SSH User |
| user_data | User data to be used on these instances (cloud-init) |
| zone_list | Element by zone list |

