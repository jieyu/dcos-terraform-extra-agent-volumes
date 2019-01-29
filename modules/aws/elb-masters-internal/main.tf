/**
 * AWS ELB Internal
 * ============
 * This module create a load balancer for cluster internal access to masters
 *
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-elb-masters-internal" {
 *   source  = "terraform-dcos/elb-masters-internal/aws"
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

module "masters-internal" {
  source  = "../../aws/elb"
  version = "~> 0.1.0"

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

  internal = true

  listener = [
    {
      lb_port           = 5050
      instance_port     = 5050
      lb_protocol       = "http"
      instance_protocol = "http"
    },
    {
      lb_port           = 2181
      instance_port     = 2181
      lb_protocol       = "tcp"
      instance_protocol = "tcp"
    },
    {
      lb_port           = 8181
      instance_port     = 8181
      lb_protocol       = "http"
      instance_protocol = "http"
    },
    {
      lb_port           = 80
      instance_port     = 80
      lb_protocol       = "tcp"
      instance_protocol = "tcp"
    },
    {
      lb_port           = 443
      instance_port     = 443
      lb_protocol       = "tcp"
      instance_protocol = "tcp"
    },
    {
      lb_port           = 8080
      instance_port     = 8080
      lb_protocol       = "http"
      instance_protocol = "http"
    },
  ]

  https_acm_cert_arn = "${var.https_acm_cert_arn}"
  elb_name_format    = "int-%s"

  instances       = ["${var.instances}"]
  security_groups = ["${var.security_groups}"]
  subnet_ids      = ["${var.subnet_ids}"]
  internal        = true

  tags = "${var.tags}"
}