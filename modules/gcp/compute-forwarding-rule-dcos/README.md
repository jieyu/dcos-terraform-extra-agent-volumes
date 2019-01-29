GCP Forwarding Rules - DC/OS
============
This module creates forwarding rules for DC/OS.

*HINT* be aware you've set the proper compute_firewall rules to enable forwarding-rules health checks to access your instances. Could be done by using `terraform-dcos/compute-firewall/gcp`

External masters load balancer
------------------------------
This load balancer keeps an redundant entry point to the masters

Internal masters load balancer ( not implemented yet )
------------------------------
this load balancer is used for internal communication to masters

External public agents load balancer
------------------------------------
This load balancer keeps a single entry point to your public agents no matter how many you're running.

EXAMPLE
-------

```hcl
module "dcos-forwarding-rules" {
  source  = "dcos-terraform/terraform-gcp-compute-forwarding-rule-dcos/gcp"
  version = "~> 0.1.0"

  cluster_name = "production"

  masters_self_link = ["${module.masters.instances_self_link}"]
  public_agents_self_link = ["${module.public_agents.instances_self_link}"]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| labels | Add custom labels to all resources | map | `<map>` | no |
| masters_additional_rules | Additional list of rules for masters. These Rules are an additon to the default rules. | string | `<list>` | no |
| masters_self_link | List of master instances self links | list | `<list>` | no |
| public_agents_additional_rules | Additional list of rules for public agents. These Rules are an additon to the default rules. | string | `<list>` | no |
| public_agents_self_link | List of public agent instances self links | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| masters_ip_address | IP Address of master load balancer |
| public_agents_ip_address | IP Address of public agents load balancer |

