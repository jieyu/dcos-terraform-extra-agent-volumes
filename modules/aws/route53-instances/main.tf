/**
 * AWS DC/OS Route53 Records for Instances (NOTE: THIS IS CURRENTLY EXPERIMENTAL AND NOT YET SUPPORTED)
 * ============
 * This module is used to create a custom Route53 records for instances
 *
 * EXAMPLE
 * -------
 *
 *```hcl
* module "agent_route53" {
*  source                    = "dcos-terraform/route53-instances/aws"
*  cluster_name              = "dcos-cluster"
*  domain                    = "testing.us"
*  ttl                       = "60"
*  aws_zone_id               = "ABCDE1278487696B"
*
*  num             = "1"
*  public_records  = "10.10.10.120"
*  private_records = "172.1.1.120"
*  hostname_format  = "agent"
*}
*```
 */

provider "aws" {}

resource "aws_route53_record" "instance_public" {
  count   = "${var.num}"
  zone_id = "${var.aws_zone_id}"
  name    = "${format(var.hostname_format, (count.index + 1), var.cluster_name, var.domain)}"
  type    = "${var.type}"
  ttl     = "${var.ttl}"
  records = ["${element(var.public_records, count.index)}"]
}

resource "aws_route53_record" "instance_internal" {
  count   = "${var.num}"
  zone_id = "${var.aws_zone_id}"
  name    = "int-${format(var.hostname_format, (count.index + 1), var.cluster_name, var.domain)}"
  type    = "${var.type}"
  ttl     = "${var.ttl}"
  records = ["${element(var.private_records, count.index)}"]
}