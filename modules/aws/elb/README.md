[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-elb/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-elb/job/master/)
AWS ELB
============
This module create AWS ELBs for DC/OS

EXAMPLE
-------

```hcl
module "dcos-elbs" {
  source  = "terraform-dcos/elb/aws"
  version = "~> 0.1.0"

  cluster_name = "production"

  subnet_ids = ["subnet-12345678"]
  security_groups_external_masters = ["sg-12345678"]
  security_groups_external_public_agents = ["sg-12345678"]
  master_instances = ["i-00123456789e960f8"]
  public_agent_instances = ["i-00123456789e960f8"]

  aws_external_masters_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_listener | List of additional listeners | string | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| connection_draining | Enable connection draining | string | `false` | no |
| cross_zone_load_balancing | Enable cross-zone load balancing | string | `true` | no |
| elb_name_format | Printf style format for naming the ELB. Gets truncated to 32 characters. (input cluster_name) | string | `load-balancer-%s` | no |
| health_check | Health check definition. | map | `<map>` | no |
| https_acm_cert_arn | ACM certifacte to be used. | string | `` | no |
| idle_timeout | Time in seconds the connection is allowed to be idle | string | `60` | no |
| instances | List of instance IDs | list | - | yes |
| internal | This ELB is internal only | string | `false` | no |
| listener | List of listeners. By default HTTP and HTTPS are set. If set it overrides the default listeners. | string | `<list>` | no |
| security_groups | Security Group IDs to use | list | `<list>` | no |
| subnet_ids | List of subnet IDs created in this network | list | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns_name | DNS Name of the master load balancer |

