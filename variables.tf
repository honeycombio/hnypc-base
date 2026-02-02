# Input variables for Route53 hosted zone configuration

variable "dns_zone_name" {
  description = "The DNS zone name for the Route53 hosted zone (e.g., 'example.com')"
  type        = string
}
