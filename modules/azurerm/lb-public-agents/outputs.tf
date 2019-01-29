# LB Address
output "lb_address" {
  description = "lb address"

  value = "${module.public-agents.lb_address}"
}

# Public backend address pool ID
output "backend_address_pool" {
  description = "backend address pool"

  value = "${module.public-agents.backend_address_pool}"
}
