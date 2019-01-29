variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "subnet_ids" {
  description = "List of subnet IDs created in this network"
  type        = "list"
}

variable "security_groups" {
  description = "Security Group IDs to use"
  type        = "list"
  default     = []
}

variable "instances" {
  description = "List of instance IDs"
  type        = "list"
}

variable "https_acm_cert_arn" {
  description = "ACM certifacte to be used."
  default     = ""
}

variable "internal" {
  description = "This ELB is internal only"
  default     = ""
}

variable "num_instances" {
  description = "How many instances should be created"
}
