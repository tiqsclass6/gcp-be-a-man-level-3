variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "class-6-5-tiqs"
}

variable "default_region" {
  description = "Default region (Tokyo)"
  type        = string
  default     = "asia-northeast1"
}

variable "default_zone" {
  description = "Default zone (Tokyo)"
  type        = string
  default     = "asia-northeast1-a"
}

variable "region_sao_paulo" {
  description = "Region for São Paulo"
  type        = string
  default     = "southamerica-east1"
}

variable "zone_sao_paulo" {
  description = "Zone for São Paulo"
  type        = string
  default     = "southamerica-east1-a"
}

variable "vpc_name" {
  default = "multi-region-vpc"
}

variable "tokyo_subnet_cidr" {
  default = "10.233.10.0/24"
}

variable "sao_paulo_subnet_cidr" {
  default = "10.233.40.0/24"
}