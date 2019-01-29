[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-lb/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-lb/job/master/)
AWS LB - Application and Network Load Balancer
============
This module create Application and Network Load Balancers. Beaware that Application supports only "HTTP" and "HTTPS" whereas Netowrk only supports "TCP" and "UDP"

EXAMPLE
-------

```hcl
module "dcos-masters-lb" {
  source  = "terraform-dcos/lb/aws"
  version = "~> 0.1"

  cluster_name = "production"

  subnet_ids = ["subnet-12345678"]
  load_balancer_type = "application"
  additional_listener = [{
    port = 8080
    protocol = "http"
  }]

  https_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_listener | List of additional listeners | string | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| cross_zone_load_balancing | Enable cross-zone load balancing | string | `true` | no |
| elb_name_format | Printf style format for naming the ELB. Gets truncated to 32 characters. (input cluster_name) | string | `load-balancer-%s` | no |
| health_check | Health check definition. | map | `<map>` | no |
| https_acm_cert_arn | ACM certifacte to be used. | string | `` | no |
| instances | List of instance IDs | list | - | yes |
| internal | This ELB is internal only | string | `false` | no |
| listener | List of listeners. By default HTTP and HTTPS are set. If set it overrides the default listeners. | string | `<list>` | no |
| load_balancer_type | Load Balancer type. Allowed values network, application | string | `network` | no |
| num_instances | How many instances should be created | string | - | yes |
| security_groups | Security Group IDs to use | list | `<list>` | no |
| subnet_ids | List of subnet IDs created in this network | list | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns_name | DNS Name of the master load balancer |

