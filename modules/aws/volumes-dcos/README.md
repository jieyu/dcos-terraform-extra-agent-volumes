AWS DC/OS Additional EBS Volumes and Attachments (NOTE: THIS IS CURRENTLY EXPERIMENTAL AND NOT YET SUPPORTED)
===========
This module creates additional ebs volumes and attaches them to the instances. This is based on best practices for DC/OS.

EXAMPLE
-------

```hcl
module "agent_volumes" {
 source = "dcos-terraform/volumes-dcos/aws"
 num                     = "3"
 instance_id             = ["id-ablsldhfa123", "id-blahblah1234", "id-abncsss43112"]
 availability_zone       = ["us-east-1a", "us-east-1b", "us-east-1c"]
 mesos_size              = "500"
 docker_size             = "250"
 log_size                = "800"
 disk_type               = "gp2"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zone | AZ(s) of where to create the Volumes | list | - | yes |
| disk_type | Type of disk | string | `gp2` | no |
| docker_size | Size of the /var/lib/docker disk | string | `100` | no |
| extra_volume_size | Size of an extra Volume | string | `50` | no |
| instance_id | The instance ID to attach the disks to | list | - | yes |
| log_size | Size of the /var/log disk | string | `500` | no |
| mesos_size | Size of the /var/lib/mesos disk | string | `250` | no |
| num | Number of Instances | string | `1` | no |

