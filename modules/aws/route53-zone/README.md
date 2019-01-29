AWS DC/OS Route53 Zone (NOTE: THIS IS CURRENTLY EXPERIMENTAL AND NOT YET SUPPORTED)
============
This module is used to create a Route53 Zone

EXAMPLE
-------

```hcl
module "route_53_zone" {
 source                    = "dcos-terraform/route53-zone/aws"
 name                      = "testing.us"
 vpc_id                    = "vpc-123213bkjdfgab"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the hosted zone | string | - | yes |
| vpc_id | The VPC to associate with a private hosted zone. Specifying vpc_id will create a private hosted zone. | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| zone_id | ID of the Zone Created |

