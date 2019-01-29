DC/OS VPC
===========
This is an module to create a AWS VPC specially used for DC/OS

This modules creates a subnet for every .

EXAMPLE
-------
```hcl
module "dcos-vpc" {
  source  = "dcos-terraform/vpc/aws"
  version = "~> 0.1.0"

  cluster_name = "production"
  availability_zones = ["us-east-1b"]
  subnet_range = "172.12.0.0/16"
  # providers {
  # aws = "aws.my-provider"
  # }
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zones | Availability zones to be used | list | `<list>` | no |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| subnet_range | Private IP space to be used in CIDR format | string | `172.31.0.0/16` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws_main_route_table_id | AWS main route table id |
| cidr_block | Output the cidr_block used within this network |
| subnet_ids | List of subnet IDs created in this network |
| subnets | List of subnet IDs created in this Network |
| vpc_id | AWS VPC ID |

