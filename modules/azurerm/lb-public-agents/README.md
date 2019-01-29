[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-public-agents/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-public-agents/job/master/)

Azure LB Public Agents
============
This module create a load balancer to acces public agents externally

EXAMPLE
-------

```hcl
module "lb-public-agents" {
  source  = "dcos-terraform/lb-public-agents/azurerm"
  version = "~> 0.1.0"

  cluster_name = "production"

  location            = ["North Europe"]
  resource_group_name = "my-resource-group"
  additional_rules    = [{ frontend_port = 8080 }]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_rules | List of additional rules | string | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| location | Azure Region | string | - | yes |
| resource_group_name | Name of the azure resource group | string | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| backend_address_pool | Public backend address pool ID |
| lb_address | LB Address |

