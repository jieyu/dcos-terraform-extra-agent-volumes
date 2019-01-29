# LB Address
output "masters.lb_address" {
  description = "lb address"

  value = "${module.masters.lb_address}"
}

# Public backend address pool ID
output "masters.backend_address_pool" {
  description = "backend address pool"

  value = "${module.masters.backend_address_pool}"
}

# LB Address
output "masters-internal.lb_address" {
  description = "lb address"

  value = "${module.masters-internal.lb_address}"
}

# Public backend address pool ID
output "masters-internal.backend_address_pool" {
  description = "backend address pool"

  value = "${module.masters-internal.backend_address_pool}"
}

# LB Address
output "public-agents.lb_address" {
  description = "lb address"

  value = "${module.public-agents.lb_address}"
}

# Public backend address pool ID
output "public-agents.backend_address_pool" {
  description = "backend address pool"

  value = "${module.public-agents.backend_address_pool}"
}
