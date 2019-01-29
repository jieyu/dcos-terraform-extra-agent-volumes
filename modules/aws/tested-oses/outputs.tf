output "user" {
  description = "User"
  value       = "${data.template_file.aws_ami_user.rendered}"
}

output "aws_ami" {
  description = "AMI that will be used for the instances instead of Mesosphere provided AMIs"
  value       = "${data.template_file.aws_ami.rendered}"
}

output "os-setup" {
  description = "os-setup"
  value       = "${data.template_file.os-setup.rendered}"
}
