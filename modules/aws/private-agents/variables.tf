variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "aws_ami" {
  description = "AMI that will be used for the instances instead of Mesosphere provided AMIs"
  default     = ""
}

variable "aws_instance_type" {
  description = "Instance type"
  default     = "t2.medium"
}

variable "aws_root_volume_size" {
  description = "Root volume size in GB"
  default     = "120"
}

variable "aws_root_volume_type" {
  description = "Root volume type"
  default     = "standard"
}

variable "aws_num_extra_volumes" {
  description = "Number of extra volumes"
  default     = "0"
}

variable "aws_extra_volume_sizes" {
  description = "Volume sizes for extra volumes"
  default     = ["120"]
}

variable "aws_extra_volume_types" {
  description = "Volume types for extra volumes"
  default     = [""]
}

variable "aws_extra_volume_iopses" {
  description = "Volume iopses for extra volumes"
  default     = ["0"]
}

variable "aws_subnet_ids" {
  description = "Subnets to spawn the instances in. The module tries to distribute the instances"
  type        = "list"
}

variable "aws_security_group_ids" {
  description = "Firewall IDs to use for these instances"
  type        = "list"
}

variable "aws_iam_instance_profile" {
  description = "Instance profile to be used for these instances"
  default     = ""
}

variable "aws_associate_public_ip_address" {
  description = "Associate a public IP address with the instances"
  default     = true
}

variable "user_data" {
  description = "User data to be used on these instances (cloud-init)"
  default     = ""
}

// TODO: Maybe use a list instead and provision keys through cloudinit
variable "aws_key_name" {
  description = "Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string"
}

variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "%[3]s-privateagent%[1]d-%[2]s"
}

variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "centos_7.4"
}

variable "num_private_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
  default     = "1"
}
