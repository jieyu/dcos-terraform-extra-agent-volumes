# LB Address
output "lb_address" {
  description = "lb address"

  value = "${module.masters-internal.lb_address}"
}

# Public backend address pool ID
output "backend_address_pool" {
  description = "backend address pool"

  value = "${module.masters-internal.backend_address_pool}"
}
