AWS LB Internal
============
This module create a network load balancer for cluster internal access to masters


EXAMPLE
-------

```hcl
module "dcos-lb-masters-internal" {
  source  = "terraform-dcos/lb-masters-internal/aws"
  version = "~> 0.1"

  cluster_name = "production"

  subnet_ids = ["subnet-12345678"]
  security_groups = ["sg-12345678"]

  instances = ["i-00123456789e960f8"]
  num_instances = 1

  https_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| https_acm_cert_arn | ACM certifacte to be used. | string | `` | no |
| instances | List of instance IDs | list | - | yes |
| num_instances | How many instances should be created | string | - | yes |
| security_groups | Security Group IDs to use | list | `<list>` | no |
| subnet_ids | List of subnet IDs created in this network | list | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns_name | DNS Name of the master load balancer |

