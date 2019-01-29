variable "cluster_name" {
  description = "Cluster name all resources get named and tagged with"
}

variable "aws_zone_id" {
  description = "The Route 53 Zone ID to be used"
}

variable "aws_target_zone_id" {
  description = "The Zone ID of the ELB"
}

variable "type" {
  description = "Type of Record"
  default     = "A"
}

variable "aws_lb_alias_name" {
  description = "Alias for the LB for the Master Address if specified"
  default     = ""
}

variable "domain" {
  description = "The domain of your Route 53 Zone"
}

variable "evaluate_target_heatlh" {
  description = "Route 53 to determine whether to respond to DNS queries using this resource record"
  default     = "false"
}
