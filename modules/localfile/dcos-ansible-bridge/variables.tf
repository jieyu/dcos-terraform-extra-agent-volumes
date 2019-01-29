variable "bootstrap_ip" {
  description = "The bootstrap IP to SSH to"
}

variable "master_ips" {
  type        = "list"
  description = "List of masterips to SSH to"
}

variable "private_agent_ips" {
  type        = "list"
  description = "List of private agent IPs to SSH to"
}

variable "public_agent_ips" {
  type        = "list"
  description = "List of public agent IPs to SSH to"
}

variable "bootstrap_private_ip" {
  description = "Private IP bootstrap nginx is listening on. Used to build the bootstrap URL."
}

variable "master_private_ips" {
  type        = "list"
  description = "list of master private ips"
}
