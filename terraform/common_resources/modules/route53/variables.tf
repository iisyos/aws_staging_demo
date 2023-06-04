variable "domain" {
  description = "The domain name"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string

}

variable "alb_zone_id" {
  description = "The Zone ID of the ALB"
  type        = string
}