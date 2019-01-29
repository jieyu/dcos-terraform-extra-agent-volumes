/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-lb/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-aws-lb/job/master/)
 * AWS LB - Application and Network Load Balancer
 * ============
 * This module create Application and Network Load Balancers. Beaware that Application supports only "HTTP" and "HTTPS" whereas Netowrk only supports "TCP" and "UDP"
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-masters-lb" {
 *   source  = "terraform-dcos/lb/aws"
 *   version = "~> 0.1"
 *
 *   cluster_name = "production"
 *
 *   subnet_ids = ["subnet-12345678"]
 *   load_balancer_type = "application"
 *   additional_listener = [{
 *     port = 8080
 *     protocol = "http"
 *   }]
 *
 *   https_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
 * }
 *```
 */

provider "aws" {}

resource "tls_private_key" "selfsigned" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "selfsigned" {
  key_algorithm   = "ECDSA"
  private_key_pem = "${tls_private_key.selfsigned.private_key_pem}"

  subject {
    common_name  = "${aws_lb.loadbalancer.dns_name}"
    organization = "Mesosphere Inc."
  }

  validity_period_hours = 85440

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_iam_server_certificate" "selfsigned" {
  name             = "${format(var.elb_name_format,var.cluster_name)}-cert"
  certificate_body = "${tls_self_signed_cert.selfsigned.cert_pem}"
  private_key      = "${tls_private_key.selfsigned.private_key_pem}"
}

data "aws_subnet" "selected" {
  id = "${element(var.subnet_ids,0)}"
}

// Only 32 characters allowed for name. So we have to use substring
locals {
  elb_name = "${format(var.elb_name_format,var.cluster_name)}"

  default_listeners = [
    {
      port     = 80
      protocol = "${var.load_balancer_type == "application" ? "http" : "tcp"}"
    },
    {
      port            = 443
      protocol        = "${var.load_balancer_type == "application" ? "https" : "tcp"}"
      certificate_arn = "${var.load_balancer_type == "application" ? coalesce(var.https_acm_cert_arn, "selfsigned") : ""}"
    },
  ]

  concat_listeners = ["${coalescelist(var.listener, concat(local.default_listeners,var.additional_listener))}"]
  instances        = ["${var.instances}"]
}

resource "aws_lb" "loadbalancer" {
  name                             = "${substr(local.elb_name,0, length(local.elb_name) >= 32 ? 32 : length(local.elb_name) )}"
  internal                         = "${var.internal}"
  load_balancer_type               = "${var.load_balancer_type}"
  subnets                          = ["${var.subnet_ids}"]
  enable_cross_zone_load_balancing = "${var.cross_zone_load_balancing}"

  # security_groups = ["${ var.load_balancer_type == "application" ? var.security_groups : list()}"]

  security_groups = ["${compact(split(",", var.load_balancer_type == "application" ? join(",", var.security_groups) : ""))}"]
  tags            = "${merge(var.tags, map("Name", format(var.elb_name_format,var.cluster_name),
                                "Cluster", var.cluster_name))}"
}

resource "aws_lb_listener" "listeners" {
  count             = "${length(local.concat_listeners)}"
  load_balancer_arn = "${aws_lb.loadbalancer.arn}"
  port              = "${lookup(local.concat_listeners[count.index], "port")}"
  protocol          = "${upper(lookup(local.concat_listeners[count.index], "protocol", var.load_balancer_type == "application" ? "http" : "tcp"))}"

  certificate_arn = "${lookup(local.concat_listeners[count.index], "certificate_arn", "") == "selfsigned" ? aws_iam_server_certificate.selfsigned.arn : lookup(local.concat_listeners[count.index], "certificate_arn", "")}"

  default_action {
    type             = "forward"
    target_group_arn = "${element(aws_lb_target_group.targetgroup.*.arn, count.index)}"
  }
}

resource "aws_lb_target_group" "targetgroup" {
  count    = "${length(local.concat_listeners)}"
  port     = "${lookup(local.concat_listeners[count.index], "port")}"
  protocol = "${upper(lookup(local.concat_listeners[count.index], "protocol", var.load_balancer_type == "application" ? "http" : "tcp"))}"
  name     = "${local.elb_name}-tg-${lookup(local.concat_listeners[count.index], "port")}"
  vpc_id   = "${data.aws_subnet.selected.vpc_id}"

  stickiness {
    type    = "lb_cookie"
    enabled = false
  }

  health_check {
    protocol = "${upper(lookup(local.concat_listeners[ceil(count.index / length(var.instances))], "protocol", var.load_balancer_type == "application" ? "http" : "tcp"))}"
    port     = "${lookup(local.concat_listeners[ceil(count.index / length(var.instances))], "port")}"
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  count            = "${var.num_instances * length(local.concat_listeners)}"
  target_group_arn = "${element(aws_lb_target_group.targetgroup.*.arn, ceil(count.index / length(var.instances)))}"
  target_id        = "${element(var.instances, count.index)}"
  port             = "${lookup(local.concat_listeners[ceil(count.index / length(var.instances))], "port")}"
}