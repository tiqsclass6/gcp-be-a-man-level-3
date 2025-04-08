resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tokyo_subnet" {
  name          = "tokyo-subnet"
  ip_cidr_range = var.tokyo_subnet_cidr
  region        = var.default_region
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "sao_paulo_subnet" {
  name          = "subnet-sao-paulo"
  ip_cidr_range = var.sao_paulo_subnet_cidr
  region        = var.region_sao_paulo
  network       = google_compute_network.vpc.id
}