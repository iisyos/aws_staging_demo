variable "environment" {
  description = "The name of environment"
}

variable "app_name" {
  type = string
}

variable "domain" {
  type = string
}

variable "image_url" {
  description = "The URL of the Docker image"
  type = string
  default = "nginx"
}