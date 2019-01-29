AWS DC/OS Private Agent Instances
============
This module creates typical private agent instances

EXAMPLE
-------

```hcl
module "dcos-private-agent-instances" {
  source  = "dcos-terraform/private-agents/aws"
  version = "~> 0.1.0"

  cluster_name = "production"
  subnet_ids = ["subnet-12345678"]
  security_group_ids = ["sg-12345678"]"
  aws_key_name = "my-ssh-key"

  num_private_agents = "2"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_ami | AMI that will be used for the instances instead of Mesosphere provided AMIs | string | `` | no |
| aws_associate_public_ip_address | Associate a public IP address with the instances | string | `true` | no |
| aws_iam_instance_profile | Instance profile to be used for these instances | string | `` | no |
| aws_instance_type | Instance type | string | `t2.medium` | no |
| aws_key_name | Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string | string | - | yes |
| aws_root_volume_size | Root volume size in GB | string | `120` | no |
| aws_root_volume_type | Root volume type | string | `standard` | no |
| aws_security_group_ids | Firewall IDs to use for these instances | list | - | yes |
| aws_subnet_ids | Subnets to spawn the instances in. The module tries to distribute the instances | list | - | yes |
| cluster_name | Name of the DC/OS cluster | string | - | yes |
| dcos_instance_os | Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `centos_7.4` | no |
| hostname_format | Format the hostname inputs are index+1, region, cluster_name | string | `%[3]s-privateagent%[1]d-%[2]s` | no |
| num_private_agents | Specify the amount of private agents. These agents will provide your main resources | string | `1` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |
| user_data | User data to be used on these instances (cloud-init) | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| instances | List of instance IDs |
| os_user | The OS user to be used |
| prereq-id | Returns the ID of the prereq script (if user_data or ami are not used) |
| private_ips | List of private ip addresses created by this module |
| public_ips | List of public ip addresses created by this module |

