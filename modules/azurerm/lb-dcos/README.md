[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-dcos/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-dcos/job/master/)

Azure LB DC/OS
============
This module creates three load balancers for DC/OS.

External masters load balancer
------------------------------
This load balancer keeps an redundant entry point to the masters

Internal masters load balancer
------------------------------
this load balancer is used for internal communication to masters

External public agents load balancer
------------------------------------
This load balancer keeps a single entry point to your public agents no matter how many you're running.

EXAMPLE
-------

```hcl
module "lb-dcos" {
  source  = "dcos-terraform/lb-dcos/azurerm"
  version = "~> 0.1"

  cluster_name = "production"

  location                       = ["North Europe"]
  resource_group_name            = "my-resource-group"
  subnet_id                      = "subnet/id/the/load-balancer/should/be/in"
  public_agents_additional_rules = [{ frontend_port = 8080 }]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| location | Azure Region | string | - | yes |
| public_agents_additional_rules | Additional list of rules for public agents. These Rules are an additon to the default rules. | string | `<list>` | no |
| resource_group_name | Name of the azure resource group | string | - | yes |
| subnet_id | Subnet ID | string | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| masters-internal.backend_address_pool | Public backend address pool ID |
| masters-internal.lb_address | LB Address |
| masters.backend_address_pool | Public backend address pool ID |
| masters.lb_address | LB Address |
| public-agents.backend_address_pool | Public backend address pool ID |
| public-agents.lb_address | LB Address |

