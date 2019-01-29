GCP Forwarding Rule - Public Agents
============
This module creates an GCP forwarding rule for DC/OS public agents.

EXAMPLE
-------

```hcl
module "dcos-forwarding-rule-public-agents" {
  source  = "dcos-terraform/compute-forwarding-rule-public-agents/gcp"
  version = "~> 0.1.0"

  cluster_name = "production"

  public_agents_self_link = [${"module.public_agents.instances_self_link"}]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_rules | List of additional rules | string | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| labels | Add custom labels to all resources | map | `<map>` | no |
| name_format | printf style format for naming the ELB. Gets truncated to 32 characters. (input cluster_name) | string | `ext-%s` | no |
| public_agents_self_link | List of public agent instances self links | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| ip_address | Load balancer ip address |

