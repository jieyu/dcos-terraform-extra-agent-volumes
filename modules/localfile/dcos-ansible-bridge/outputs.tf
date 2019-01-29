output "depends" {
  description = "Modules are missing the depends_on feature. Faking this feature with input and output variables"
  value       = "${join(",", flatten(list(local_file.ansible_inventory.id,local_file.ansible_groupvars.id)))}"
}
