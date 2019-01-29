# Output
output "user" {
  description = "User"
  value       = "${local.user}"
}

output "image_family" {
  description = "GCP Image Family Name"
  value       = "${local.image_family}"
}

output "image_name" {
  description = "GCP Image Name"
  value       = "${local.image_name}"
}

output "os-setup" {
  description = "os-setup"
  value       = "${local.script}"
}
