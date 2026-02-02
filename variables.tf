variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state storage"
  type        = string
}

variable "state_bucket_retention_days" {
  description = "Number of days to retain noncurrent versions of state files"
  type        = number
  default     = 90
}
