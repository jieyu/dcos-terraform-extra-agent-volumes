DC/OS Terraform-Ansible-Bridge (Inventory and group_vars generator)
============
This module creates two local files that can be used by Ansible to manage a DC/OS cluster.

EXAMPLE
-------

```hcl
module "dcos-ansible-bridge" {
  source  = "dcos-terraform/dcos-ansible-bridge/local_file"
  version = "~> 0.1"

  bootstrap_ip         = "${module.dcos-infrastructure.bootstrap.public_ip}"
  master_ips           = ["${module.dcos-infrastructure.masters.public_ips}"]
  private_agent_ips    = ["${module.dcos-infrastructure.private_agents.public_ips}"]
  public_agent_ips     = ["${module.dcos-infrastructure.public_agents.public_ips}"]

  bootstrap_private_ip = "${module.dcos-infrastructure.bootstrap.private_ip}"
  master_private_ips   = ["${module.dcos-infrastructure.masters.private_ips}"]
}

module "dcos-infrastructure" {
  source  = "dcos-terraform/infrastructure/aws"
  version = "~> 0.1"

  [...]

}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bootstrap_ip | The bootstrap IP to SSH to | string | - | yes |
| bootstrap_private_ip | Private IP bootstrap nginx is listening on. Used to build the bootstrap URL. | string | - | yes |
| master_ips | List of masterips to SSH to | list | - | yes |
| master_private_ips | list of master private ips | list | - | yes |
| private_agent_ips | List of private agent IPs to SSH to | list | - | yes |
| public_agent_ips | List of public agent IPs to SSH to | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| depends | Modules are missing the depends_on feature. Faking this feature with input and output variables |

