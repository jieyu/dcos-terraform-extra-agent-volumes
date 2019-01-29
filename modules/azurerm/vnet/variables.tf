# VNet CIDR
variable "subnet_range" {
  description = "Private IP space to be used in CIDR format"
  default     = "172.31.0.0/16"
}

# Location (region)
variable "location" {
  description = "Azure Region"
}

# Cluster Name
variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

# Resource Group Name
variable "resource_group_name" {
  description = "Name of the azure resource group"
}

# Add special tags to the resources created by this module
variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}
