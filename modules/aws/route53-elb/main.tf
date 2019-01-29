/**
 * AWS DC/OS Route53 Alias for ELB (NOTE: THIS IS CURRENTLY EXPERIMENTAL AND NOT YET SUPPORTED)
 * ============
 * This module is used to create a custom Route53 alias for your Masters ELB
 *
 * EXAMPLE
 * -------
 *
 *```hcl
* module "elb_masters" {
*  source               = "dcos-terraform/route53-elb/aws"
*  cluster_name         = "dcos-cluster"
*  domain               = "domain.com"
*  aws_zone_id          = "ABC123456XYZ"
*  aws_target_zone_id   = "XYZ9876543AB"
*  aws_lb_alias_name    = "master-elb-abdfadhf132123123"
*}
*```
 */

provider "aws" {}

resource "aws_route53_record" "masters_alias" {
  zone_id = "${var.aws_zone_id}"
  name    = "${var.cluster_name}.${var.domain}"
  type    = "${var.type}"

  alias {
    name                   = "${var.aws_lb_alias_name}"
    zone_id                = "${var.aws_target_zone_id}"
    evaluate_target_health = "${var.evaluate_target_heatlh}"
  }
}