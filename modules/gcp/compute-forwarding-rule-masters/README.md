GCP Forwarding Rule - Masters
============
This module creates an GCP forwarding rule for DC/OS masters. The default ports are `80` and `443`. Also a default healthcheck is applied.

EXAMPLE
-------

```hcl
module "dcos-forwarding-rule-masters" {
  source  = "dcos-terraform/compute-forwarding-rule-masters/gcp"
  version = "~> 0.1.0"

  cluster_name = "production"

  masters_self_link = [${"module.masters.instances_self_link"}]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_rules | List of additional rules | string | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| labels | Add custom labels to all resources | map | `<map>` | no |
| masters_self_link | List of master instances self links | list | `<list>` | no |
| name_format | printf style format for naming the ELB. Gets truncated to 32 characters. (input cluster_name) | string | `m-%s` | no |

## Outputs

| Name | Description |
|------|-------------|
| ip_address | Load balancer ip address |

