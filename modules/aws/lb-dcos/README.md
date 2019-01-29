AWS LB DC/OS
============
This module creates three load balancers for DC/OS.

External masters application load balancer
------------------------------------------
This load balancer keeps an redundant entry point to the masters

Internal masters network load balancer
--------------------------------------
this load balancer is used for internal communication to masters

External public agents network load balancer
--------------------------------------------
This load balancer keeps a single entry point to your public agents no matter how many you're running.

EXAMPLE
-------

```hcl
module "dcos-lbs" {
  source  = "dcos-terraform/lb-dcos/aws"
  version = "~> 0.1"

  cluster_name = "production"

  subnet_ids = ["subnet-12345678"]
  security_groups_masters = ["sg-12345678"]
  security_groups_masters_internal = ["sg-12345678"]
  security_groups_public_agents = ["sg-12345678"]
  master_instances = ["i-00123456789e960f8"]
  public_agent_instances = ["i-00123456789e960f8"]

  masters_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| internal | This ELB is internal only | string | `false` | no |
| master_instances | List of master instance IDs | list | - | yes |
| masters_acm_cert_arn | ACM certifacte to be used for the masters load balancer | string | `` | no |
| masters_internal_acm_cert_arn | ACM certifacte to be used for the internal masters load balancer | string | `` | no |
| num_masters | Specify the amount of masters. For redundancy you should have at least 3 | string | - | yes |
| num_public_agents | Specify the amount of public agents. These agents will host marathon-lb and edgelb | string | - | yes |
| public_agent_instances | List of public agent instance IDs | list | - | yes |
| public_agents_acm_cert_arn | ACM certifacte to be used for the public agents load balancer | string | `` | no |
| public_agents_additional_listeners | Additional list of listeners for public agents. These listeners are an additon to the default listeners. | list | `<list>` | no |
| security_groups_masters | Security Group IDs to use for external masters load balancer | list | - | yes |
| security_groups_masters_internal | Security Group IDs to use for internal communication to masters | list | - | yes |
| security_groups_public_agents | Security Group IDs to use for external public agents load balancer | list | - | yes |
| subnet_ids | List of subnet IDs created in this network | list | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| masters_dns_name | DNS Name of the master load balancer |
| masters_internal_dns_name | DNS Name of the master load balancer |
| public_agents_dns_name | DNS Name of the public agent load balancer |

