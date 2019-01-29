# DC/OS Terraform with Extra Agent Volumes Support

*NOTE*: There is no support for this repository!
Use at your own risk.

## Get Started

First, make sure [terraform](https://docs.mesosphere.com/1.12/installing/evaluation/aws/#install-terraform) is installed.

Then, `cd` into the root of this repository.

```bash
$ terraform init
$ terraform apply
```

You can change `main.tf` to customize your DC/OS installation.

## Customize Extra Agent Volumes

The relevant fields related to agent volumes are the following:

```hcl
module "dcos" {
  # ...

  private_agents_num_extra_volumes   = "2"
  private_agents_extra_volume_sizes  = ["100", "200"]
  private_agents_extra_volume_types  = ["", "gp2"]
  private_agents_extra_volume_iopses = ["", "100"]

  # ...
}
```
