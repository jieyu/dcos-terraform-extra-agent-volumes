output "user" {
  description = "User"
  value       = "${data.template_file.traditional_os_user.rendered}"
}

output "azure_offer" {
  description = "Azure Offer"
  value       = "${data.template_file.azure_offer.rendered}"
}

output "azure_publisher" {
  description = "Azure Publisher"
  value       = "${data.template_file.azure_publisher.rendered}"
}

output "azure_sku" {
  description = "Azure SKU"
  value       = "${data.template_file.azure_sku.rendered}"
}

output "azure_version" {
  description = "Azure Version"
  value       = "${data.template_file.azure_version.rendered}"
}

output "os-setup" {
  description = "os-setup"
  value       = "${data.template_file.os-setup.rendered}"
}
