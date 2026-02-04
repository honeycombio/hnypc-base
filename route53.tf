# Route53 Hosted Zone
# Creates a public hosted zone for DNS management

resource "aws_route53_zone" "main" {
  count   = var.dns_zone_name != null ? 1 : 0
  name    = var.dns_zone_name
  comment = "Managed by Terraform"
}
