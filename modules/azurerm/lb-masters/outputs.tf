# LB Address
output "lb_address" {
  description = "lb address"

  value = "${module.masters.lb_address}"
}

# Public backend address pool ID
output "backend_address_pool" {
  description = "backend address pool"

  value = "${module.masters.backend_address_pool}"
}
