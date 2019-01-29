/**
 * AWS EBS
 * =======
 * This module creates additional ebs volumes and attaches them to the instances.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "instance-volume" {
 *   source = "dcos-terraform/ebs/aws"
 *
 *   instances          = ["id-ablsldhfa123", "id-aidrkdkek131"]
 *   num                = "3"
 *   sizes              = ["500", "100", "1000"]
 *   types              = ["", "", "gp2"]
 *   iopses             = ["0", "300", "3000"]
 * }
 *```
 */

provider "aws" {}

data "aws_instance" "instance" {
  count       = "${var.num_instances}"
  instance_id = "${element(var.instances, count.index)}"
}

locals {
  device_names = [
    "/dev/xvdi",
    "/dev/xvdj",
    "/dev/xvdk",
    "/dev/xvdm",
    "/dev/xvdn",
    "/dev/xvdo",
    "/dev/xvdp",
    "/dev/xvdq",
    "/dev/xvdr",
    "/dev/xvds",
  ]
}

resource "aws_ebs_volume" "volume" {
  # We group volumes from one instance first. For instance:
  # - var.num = 2
  # - var.num_instances = 3
  #
  # We will get:
  # - volume.0 (instance 0)
  # - volume.1 (instance 0)
  # - volume.2 (instance 1)
  # - volume.3 (instance 1)
  # - volume.4 (instance 2)
  # - volume.5 (instance 2)
  count = "${var.num * var.num_instances}"

  availability_zone = "${element(data.aws_instance.instance.*.availability_zone, count.index / (var.num > 0 ? var.num : 1))}"
  size              = "${element(var.sizes, count.index % (var.num > 0 ? var.num : 1))}"
  type              = "${element(var.types, count.index % (var.num > 0 ? var.num : 1))}"
  iops              = "${element(var.iopses, count.index % (var.num > 0 ? var.num : 1))}"

  tags = "${merge(var.tags, map(
                "Name", format(var.ebs_name_format,
                               var.cluster_name,
                               element(var.instances, count.index / (var.num > 0 ? var.num : 1))),
                "Cluster", var.cluster_name))}"
}

resource "aws_volume_attachment" "volume-attachment" {
  count        = "${var.num * var.num_instances}"
  device_name  = "${element(local.device_names, count.index % (var.num > 0 ? var.num : 1))}"
  volume_id    = "${element(aws_ebs_volume.volume.*.id, count.index)}"
  instance_id  = "${element(var.instances, count.index / (var.num > 0 ? var.num : 1))}"
  force_detach = true
}