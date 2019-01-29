/**
* AWS DC/OS Additional EBS Volumes and Attachments (NOTE: THIS IS CURRENTLY EXPERIMENTAL AND NOT YET SUPPORTED)
* ===========
* This module creates additional ebs volumes and attaches them to the instances. This is based on best practices for DC/OS. 
*
* EXAMPLE
* -------
*
*```hcl
*module "agent_volumes" {
*  source = "dcos-terraform/volumes-dcos/aws"
*  num                     = "3"
*  instance_id             = ["id-ablsldhfa123", "id-blahblah1234", "id-abncsss43112"]
*  availability_zone       = ["us-east-1a", "us-east-1b", "us-east-1c"]
*  mesos_size              = "500"
*  docker_size             = "250"
*  log_size                = "800"
*  disk_type               = "gp2"
*}
*```
*/

provider "aws" {}

resource "aws_ebs_volume" "mesos" {
  count             = "${var.num}"
  availability_zone = "${element(var.availability_zone, count.index + 0)}"
  type              = "${var.disk_type}"
  size              = "${var.mesos_size}"
}

resource "aws_volume_attachment" "mesos_attach" {
  count        = "${var.num}"
  device_name  = "/dev/xvde"
  volume_id    = "${element(aws_ebs_volume.mesos.*.id, count.index + 0)}"
  instance_id  = "${element(var.instance_id, count.index + 0)}"
  force_detach = true
}

resource "aws_ebs_volume" "docker" {
  count             = "${var.num}"
  availability_zone = "${element(var.availability_zone, count.index + 0)}"
  type              = "${var.disk_type}"
  size              = "${var.docker_size}"
}

resource "aws_volume_attachment" "docker_attach" {
  count        = "${var.num}"
  device_name  = "/dev/xvdf"
  volume_id    = "${element(aws_ebs_volume.docker.*.id, count.index + 0)}"
  instance_id  = "${element(var.instance_id, count.index + 0)}"
  force_detach = true
}

resource "aws_ebs_volume" "volume0" {
  count             = "${var.num}"
  availability_zone = "${element(var.availability_zone, count.index + 0)}"
  type              = "${var.disk_type}"
  size              = "${var.extra_volume_size}"
}

resource "aws_volume_attachment" "volume0_attach" {
  count        = "${var.num}"
  device_name  = "/dev/xvdg"
  volume_id    = "${element(aws_ebs_volume.volume0.*.id, count.index + 0)}"
  instance_id  = "${element(var.instance_id, count.index + 0)}"
  force_detach = true
}

resource "aws_ebs_volume" "log" {
  count             = "${var.num}"
  availability_zone = "${element(var.availability_zone, count.index + 0)}"
  type              = "${var.disk_type}"
  size              = "${var.log_size}"
}

resource "aws_volume_attachment" "log_attach" {
  count        = "${var.num}"
  device_name  = "/dev/xvdh"
  volume_id    = "${element(aws_ebs_volume.log.*.id, count.index + 0)}"
  instance_id  = "${element(var.instance_id, count.index + 0)}"
  force_detach = true
}