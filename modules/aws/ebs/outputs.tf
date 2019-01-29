output "volumes" {
  description = "List of volume IDs"
  value       = ["${aws_ebs_volume.volume.*.id}"]
}
