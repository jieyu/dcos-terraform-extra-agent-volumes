AWS DC/OS Route53 Alias for ELB (NOTE: THIS IS CURRENTLY EXPERIMENTAL AND NOT YET SUPPORTED)
============
This module is used to create a custom Route53 alias for your Masters ELB

EXAMPLE
-------

```hcl
module "elb_masters" {
 source               = "dcos-terraform/route53-elb/aws"
 cluster_name         = "dcos-cluster"
 domain               = "domain.com"
 aws_zone_id          = "ABC123456XYZ"
 aws_target_zone_id   = "XYZ9876543AB"
 aws_lb_alias_name    = "master-elb-abdfadhf132123123"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_lb_alias_name | Alias for the LB for the Master Address if specified | string | `` | no |
| aws_target_zone_id | The Zone ID of the ELB | string | - | yes |
| aws_zone_id | The Route 53 Zone ID to be used | string | - | yes |
| cluster_name | Cluster name all resources get named and tagged with | string | - | yes |
| domain | The domain of your Route 53 Zone | string | - | yes |
| evaluate_target_heatlh | Route 53 to determine whether to respond to DNS queries using this resource record | string | `false` | no |
| type | Type of Record | string | `A` | no |

## Outputs

| Name | Description |
|------|-------------|
| public_fqdns | The alias name of the Masters ELB |

