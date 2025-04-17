variable "project_id" {
  description = "GCP project ID to deploy resources into"
  type        = string
  default     = "<Enter Project ID Here>"
}

variable "vpc_name" {
  description = "Name of the custom VPC"
  type        = string
  default     = "multi-region-vpc"
}

variable "iowa_subnet_name" {
  description = "Subnet name for Iowa region"
  type        = string
  default     = "iowa-subnet"
}

variable "sao_paulo_subnet_name" {
  description = "Subnet name for São Paulo region"
  type        = string
  default     = "sao-paulo-subnet"
}

variable "tokyo_subnet_name" {
  description = "Subnet name for Tokyo region"
  type        = string
  default     = "tokyo-subnet"
}

variable "iowa_zone" {
  description = "Zone for the Iowa VM"
  type        = string
  default     = "us-central1-a"
}

variable "sao_paulo_zone" {
  description = "Zone for the Sao Paulo VM"
  type        = string
  default     = "southamerica-east1-a"
}

variable "tokyo_zone" {
  description = "Zone for the Tokyo VM"
  type        = string
  default     = "asia-northeast1-a"
}