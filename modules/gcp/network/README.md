[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-network/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-network/job/master/)
#  terraform-gcp-network

Creates a DC/OS network for GCP for Masters and Agents

## EXAMPLE

```hcl
module "dcos-vpc" {
  source  = "dcos-terraform/network/gcp"
  version = "~> 0.1"

  agent_cidr_range = "10.65.0.0/16"
  master_cidr_range = "10.64.0.0/16"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| agent_cidr_range | Agent CIDR Range | string | - | yes |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| master_cidr_range | Master CIDR Range | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| agent_subnetwork_name | Agent Subnetwork Name |
| master_cidr_range | Master CIDR Range |
| master_subnetwork_name | Master Subnetwork Name |
| name_prefix | Cluster Name |
| network_name | Name of the network created by this module |
| self_link | Self link of the network created by this module |

