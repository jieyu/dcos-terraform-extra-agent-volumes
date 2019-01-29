/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-elb/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-elb/job/master/)
 * AWS ELB
 * ============
 * This module create AWS ELBs for DC/OS
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-elbs" {
 *   source  = "terraform-dcos/elb/aws"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "production"
 *
 *   subnet_ids = ["subnet-12345678"]
 *   security_groups_external_masters = ["sg-12345678"]
 *   security_groups_external_public_agents = ["sg-12345678"]
 *   master_instances = ["i-00123456789e960f8"]
 *   public_agent_instances = ["i-00123456789e960f8"]
 *
 *   aws_external_masters_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
 * }
 *```
 */

provider "aws" {}

// Only 32 characters allowed for name. So we have to use substring
locals {
  elb_name = "${format(var.elb_name_format,var.cluster_name)}"

  default_listeners = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
    {
      instance_port      = 443
      instance_protocol  = "${var.https_acm_cert_arn == "" ? "tcp" : "https"}"
      lb_port            = 443
      lb_protocol        = "${var.https_acm_cert_arn == "" ? "tcp" : "https"}"
      ssl_certificate_id = "${var.https_acm_cert_arn}"
    },
  ]
}

resource "aws_elb" "loadbalancer" {
  name = "${substr(local.elb_name,0, length(local.elb_name) >= 32 ? 32 : length(local.elb_name) )}"

  subnets         = ["${var.subnet_ids}"]
  security_groups = ["${var.security_groups}"]

  internal                  = "${var.internal}"
  listener                  = ["${coalescelist(var.listener, concat(local.default_listeners,var.additional_listener))}"]
  health_check              = ["${var.health_check}"]
  instances                 = ["${var.instances}"]
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  idle_timeout              = "${var.idle_timeout}"
  connection_draining       = "${var.connection_draining}"

  tags = "${merge(var.tags, map("Name", format(var.elb_name_format,var.cluster_name),
                                "Cluster", var.cluster_name))}"
}