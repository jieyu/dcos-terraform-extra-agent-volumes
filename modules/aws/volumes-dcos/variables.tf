variable "num" {
  description = "Number of Instances"
  default     = 1
}

variable "instance_id" {
  description = "The instance ID to attach the disks to"
  type        = "list"
}

variable "availability_zone" {
  description = "AZ(s) of where to create the Volumes"
  type        = "list"
}

variable "disk_type" {
  description = "Type of disk"
  default     = "gp2"
}

variable "mesos_size" {
  description = "Size of the /var/lib/mesos disk"
  default     = 250
}

variable "docker_size" {
  description = "Size of the /var/lib/docker disk"
  default     = 100
}

variable "extra_volume_size" {
  description = "Size of an extra Volume"
  default     = 50
}

variable "log_size" {
  description = "Size of the /var/log disk"
  default     = 500
}
