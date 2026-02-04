# Outputs for Route53 hosted zone

output "zone_id" {
  description = "The hosted zone ID"
  value       = one(aws_route53_zone.main[*].zone_id)
}

output "name_servers" {
  description = "The NS records to delegate to this zone from a parent zone"
  value       = one(aws_route53_zone.main[*].name_servers)
}

output "zone_name" {
  description = "The name of the hosted zone"
  value       = one(aws_route53_zone.main[*].name)
}

output "state_bucket_name" {
  description = "Name of the Terraform state S3 bucket"
  value       = aws_s3_bucket.terraform_state.id
}

output "infra_automation_role_arn" {
  value = aws_iam_role.infra_automation.arn
}

output "infra_automation_role_name" {
  value = aws_iam_role.infra_automation.name
}

