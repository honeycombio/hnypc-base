# Route53 Hosted Zone
# Creates a public hosted zone for DNS management

resource "aws_route53_zone" "main" {
  name    = var.dns_zone_name
  comment = "Managed by Terraform"
}
