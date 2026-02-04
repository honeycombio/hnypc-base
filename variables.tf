# Input variables for Route53 hosted zone configuration

variable "create_route53_zone" {
  type        = bool
  default     = true
  description = <<DOC
Set to false to skip creating the route53 zone.

HnyPC requires a Route53 hosted zone to function. Set this to false if you plan
on provisioning a hosted zone out-of-band.
DOC
}

variable "dns_zone_name" {
  description = "The DNS zone name for the Route53 hosted zone (e.g., 'example.com')"
  type        = string
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state storage"
  type        = string
}

variable "state_bucket_retention_days" {
  description = "Number of days to retain noncurrent versions of state files"
  type        = number
  default     = 90
}

variable "hnypc_prefix" {
  description = "Prefix for HnyPC resources"
  type        = string
  default     = "hnypc"
}

variable "infra_automation_role_trust_policy_json" {
  type        = string
  description = <<DOC
The trust policy for the infra-automation IAM role

https://aws.amazon.com/blogs/security/how-to-use-trust-policies-with-iam-roles/
DOC
}

