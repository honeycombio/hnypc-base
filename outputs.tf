# Outputs for Route53 hosted zone

output "zone_id" {
  description = "The hosted zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "name_servers" {
  description = "The NS records to delegate to this zone from a parent zone"
  value       = aws_route53_zone.main.name_servers
}

output "zone_name" {
  description = "The name of the hosted zone"
  value       = aws_route53_zone.main.name
}
