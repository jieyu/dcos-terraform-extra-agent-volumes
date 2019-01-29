# Standard Default OS Users
variable "traditional_default_os_user" {
  description = "Standard Default OS Users"
  type        = "map"

  default = {
    coreos = "core"
    centos = "centos"
    ubuntu = "ubuntu"
    rhel   = "ec2-user"
  }
}

# GCP Images
variable "os_image_version" {
  description = "GCP Images"
  type        = "map"

  # GCP Image Schema # image family   /   image name
  #                                  V                  V
  default = {
    "centos_7.2"      = ["centos-cloud", "centos-7-v20170523"]
    "centos_7.3"      = ["centos-cloud", "centos-7-v20170719"]
    "centos_7.5"      = ["centos-cloud", "centos-7-v20181011"]
    "coreos_stable"   = ["coreos-cloud", "coreos-stable"]
    "coreos_1576.5.0" = ["coreos-cloud", "coreos-stable-1576-5-0-v20180105"]
    "coreos_1855.5.0" = ["coreos-cloud", "coreos-stable-1855-5-0-v20181024"]
    "rhel_7.3"        = ["rhel-cloud", "rhel-7-v20170523"]
    ""                = ["", ""]
  }
}

# OS name_version
variable "os" {
  description = "Operating system to use"
  default     = "centos_7.3"
}

# DCOS Version prereqs
variable "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list."
  default     = "1.7"
}
