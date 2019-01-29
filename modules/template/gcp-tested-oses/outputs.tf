# Output
output "user" {
  description = "user"
  value       = "${data.template_file.traditional_os_user.rendered}"
}

# GCP Image Family Name
output "image_family" {
  description = "image family"
  value       = "${data.template_file.image_family.rendered}"
}

# GCP Image Name
output "image_name" {
  description = "image name"
  value       = "${data.template_file.image_name.rendered}"
}

# Main Output
output "os-setup" {
  description = "os-setup"
  value       = "${data.template_file.os-setup.rendered}"
}
