# Cluster Name
variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

# Master CIDR Range
variable "master_cidr_range" {
  description = "Master CIDR Range"
}

# Agent CIDR Range
variable "agent_cidr_range" {
  description = "Agent CIDR Range"
}
