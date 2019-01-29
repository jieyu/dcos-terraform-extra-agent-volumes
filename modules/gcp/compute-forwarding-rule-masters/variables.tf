variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "name_format" {
  description = "printf style format for naming the ELB. Gets truncated to 32 characters. (input cluster_name)"
  default     = "m-%s"
}

variable "masters_self_link" {
  description = "List of master instances self links"
  type        = "list"
  default     = []
}

variable "additional_rules" {
  description = "List of additional rules"
  default     = []
}

variable "labels" {
  description = "Add custom labels to all resources"
  type        = "map"
  default     = {}
}
