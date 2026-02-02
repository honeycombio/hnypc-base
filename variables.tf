# Input variables for Route53 hosted zone configuration

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
