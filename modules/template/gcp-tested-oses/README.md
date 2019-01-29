[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-template-gcp-tested-oses/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-template-gcp-tested-oses/job/master/)
# Tested DC/OS OSes GCP

This is a module that properly configures the DC/OS prerequisites for selected OSes on top of GCP.

## EXAMPLE

```hcl
module "dcos-tested-gcp-oses" {
   source   = "./modules/dcos-tested-gcp-oses"
   os       = "${var.os}"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dcos_version | Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list. | string | `1.7` | no |
| enabled | enabled | string | `false` | no |
| os | Operating system to use | string | - | yes |
| os_image_version | os image version | map | `<map>` | no |
| provider | provider | string | `gcp` | no |
| traditional_default_os_user | traditional default os user | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| image_family | GCP Image Family Name |
| image_name | GCP Image Name |
| os-setup | Main Output |
| user | Output |

