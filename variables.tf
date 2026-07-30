# Input variables for Route53 hosted zone configuration

variable "dns_zone_name" {
  description = <<DOC
The DNS zone name for the Route53 hosted zone (e.g., 'example.com').

Set to null to skip creating the Route53 zone. HnyPC requires a Route53 hosted
zone to function, so set this to null only if you plan on provisioning a hosted
zone out-of-band.
DOC
  type        = string
  default     = null
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

variable "infra_automation_role_permissions_boundary_arn" {
  type        = string
  description = <<DOC
ARN of the IAM policy to attach as a permissions boundary on the
infra-automation IAM role.

Set to null to create the role without a permissions boundary.

https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html
DOC
  default     = null
}

variable "pull_through_cache_role_permissions_boundary_arn" {
  type        = string
  description = <<DOC
ARN of the IAM policy to attach as a permissions boundary on the ECR
pull-through-cache IAM role.

Set to null to create the role without a permissions boundary.

https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html
DOC
  default     = null
}

