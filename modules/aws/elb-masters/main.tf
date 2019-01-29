/**
 * AWS ELB Masters
 * ============
 * This module create a load balancer to acces the masters externally.
 *
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-elb-masters" {
 *   source  = "terraform-dcos/elb-masters/aws"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   subnet_ids = ["subnet-12345678"]
 *   security_groups = ["sg-12345678"]
 *
 *   instances = ["i-00123456789e960f8"]
 *
 *   https_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
 * }
 *```
 */

provider "aws" {}

module "masters" {
  source = "../../aws/elb"

  providers = {
    aws = "aws"
  }

  cluster_name = "${var.cluster_name}"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "TCP:5050"
    interval            = 30
  }

  https_acm_cert_arn = "${var.https_acm_cert_arn}"
  elb_name_format    = "%s"

  instances       = ["${var.instances}"]
  security_groups = ["${var.security_groups}"]
  subnet_ids      = ["${var.subnet_ids}"]
  internal        = "${var.internal}"

  tags = "${var.tags}"
}