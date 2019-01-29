/**
 * AWS DC/OS Route53 Zone (NOTE: THIS IS CURRENTLY EXPERIMENTAL AND NOT YET SUPPORTED)
 * ============
 * This module is used to create a Route53 Zone
 *
 * EXAMPLE
 * -------
 *
 *```hcl
* module "route_53_zone" {
*  source                    = "dcos-terraform/route53-zone/aws"
*  name                      = "testing.us"
*  vpc_id                    = "vpc-123213bkjdfgab"
*}
*```
 */

resource "aws_route53_zone" "main" {
  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"
}