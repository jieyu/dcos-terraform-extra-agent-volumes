AWS LB Public Agents
============
This module create a network load balancer to acces public agents externally


EXAMPLE
-------

```hcl
module "dcos-lb-public-agents" {
  source  = "terraform-dcos/lb-public-agents/aws"
  version = "~> 0.1"

  cluster_name = "production"

  subnet_ids = ["subnet-12345678"]
  security_groups = ["sg-12345678"]

  instances = ["i-00123456789e960f8"]

  https_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_listener | List of additional listeners | string | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| https_acm_cert_arn | ACM certifacte to be used. | string | `` | no |
| instances | List of instance IDs | list | - | yes |
| internal | This ELB is internal only | string | `` | no |
| num_instances | How many instances should be created | string | - | yes |
| security_groups | Security Group IDs to use | list | `<list>` | no |
| subnet_ids | List of subnet IDs created in this network | list | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns_name | DNS Name of the master load balancer |

