variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "master_cidr_range" {
  description = "Master CIDR Range"
  default     = "10.64.0.0/16"
}

variable "agent_cidr_range" {
  description = "Agent CIDR Range"
  default     = "10.65.0.0/16"
}

variable "bootstrap_disk_size" {
  description = "Bootstrap node disk size (gb)"
  default     = ""
}

variable "bootstrap_disk_type" {
  description = "Bootstrap node disk type."
  default     = ""
}

variable "bootstrap_machine_type" {
  description = "[BOOTSTRAP] Machine type"
  default     = ""
}

variable "bootstrap_image" {
  description = "[BOOTSTRAP] Image to be used"
  default     = ""
}

variable "master_disk_size" {
  description = "Master node disk size (gb)"
  default     = ""
}

variable "master_disk_type" {
  description = "Master node disk type."
  default     = ""
}

variable "master_machine_type" {
  description = "Master node machine type"
  default     = ""
}

variable "master_image" {
  description = "Master node OS image"
  default     = ""
}

variable "private_agent_disk_size" {
  description = "Private agent node disk size (gb)"
  default     = ""
}

variable "private_agent_disk_type" {
  description = "Private agent node disk type."
  default     = ""
}

variable "private_agent_machine_type" {
  description = "Private agent node machine type"
  default     = ""
}

variable "private_agent_image" {
  description = "Private agent node OS image"
  default     = ""
}

variable "public_agent_disk_size" {
  description = "Public agent disk size (gb)"
  default     = ""
}

variable "public_agent_disk_type" {
  description = "Public agent node disk type."
  default     = ""
}

variable "public_agent_machine_type" {
  description = "Public agent machine type"
  default     = ""
}

variable "public_agent_image" {
  description = "Public agent node OS image"
  default     = ""
}

variable "master_public_ssh_key_path" {
  description = "Master node Public SSH Key"
  default     = ""
}

variable "private_agent_public_ssh_key_path" {
  description = "Private Agent node Public SSH Key"
  default     = ""
}

variable "public_agent_public_ssh_key_path" {
  description = "Public Agent node Public SSH Key"
  default     = ""
}

variable "bootstrap_public_ssh_key_path" {
  description = "Bootstrap Node Public SSH Key"
  default     = ""
}

variable "master_ssh_user" {
  description = "Master node SSH User"
  default     = ""
}

variable "bootstrap_ssh_user" {
  description = "Bootstrap node SSH User"
  default     = ""
}

variable "public_agent_ssh_user" {
  description = "Public Agent node SSH User"
  default     = ""
}

variable "private_agent_ssh_user" {
  description = "Private Agent node SSH User"
  default     = ""
}

variable "infra_ssh_user" {
  description = "Global Infra SSH User"
  default     = ""
}

variable "infra_public_ssh_key_path" {
  description = "Global Infra Public SSH Key"
}

variable "infra_disk_type" {
  description = "Global Infra Disk Type"
  default     = "pd-ssd"
}

variable "infra_disk_size" {
  description = "Global Infra Disk Size"
  default     = "128"
}

variable "infra_machine_type" {
  description = "Global Infra Machine Type"
  default     = "n1-standard-8"
}

variable "infra_dcos_instance_os" {
  description = "Global Infra Tested OSes Image"
  default     = "coreos_1576.5.0"
}

variable "master_dcos_instance_os" {
  description = "Master node tested OSes image"
  default     = ""
}

variable "public_agent_dcos_instance_os" {
  description = "Public Agent node tested OSes image"
  default     = ""
}

variable "private_agent_dcos_instance_os" {
  description = "Private agent node tested OSes image"
  default     = ""
}

variable "bootstrap_dcos_instance_os" {
  description = "Bootstrap node tested OSes image"
  default     = ""
}

variable "admin_ips" {
  description = "List of CIDR admin IPs"
  type        = "list"
}

variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
  default     = "3"
}

variable "num_private_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
  default     = "1"
}

variable "num_public_agents" {
  description = "Specify the amount of public agents. These agents will host marathon-lb and edgelb"
  default     = "1"
}

variable "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list."
  default     = "1.11.4"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "list"
  default     = []
}

variable "labels" {
  description = "Add custom labels to all resources"
  type        = "map"
  default     = {}
}

variable "public_agents_additional_ports" {
  description = "List of additional ports allowed for public access on public agents (80 and 443 open by default)"
  type        = "list"
  default     = []
}
