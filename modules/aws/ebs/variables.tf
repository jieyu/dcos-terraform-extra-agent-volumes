variable "instances" {
  description = "List of instance IDs"
  type        = "list"
}

variable "num_instances" {
  description = "Number of instances"
}

variable "num" {
  description = "The number of EBS volumes to create for each instance"
}

variable "sizes" {
  description = "The sizes in GB for volumes"
  type        = "list"
  default     = ["120"]
}

variable "types" {
  description = "The types for volumes"
  type        = "list"
  default     = [""]
}

variable "iopses" {
  description = "The iopses for volumes"
  type        = "list"
  default     = ["0"]
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "ebs_name_format" {
  description = "Printf style format for naming the EBS volume. Gets truncated to 32 characters. (input cluster_name and instance ID)"
  default     = "ebs-%s-%s"
}
