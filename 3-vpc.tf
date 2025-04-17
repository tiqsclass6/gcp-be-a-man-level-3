resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "iowa_subnet" {
  name          = "iowa-subnet"
  ip_cidr_range = "10.233.10.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "brazil_subnet" {
  name          = "brazil-subnet"
  ip_cidr_range = "10.233.40.0/24"
  region        = "southamerica-east1"
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "tokyo_subnet" {
  name          = "tokyo-subnet"
  ip_cidr_range = "10.233.70.0/24"
  region        = "asia-northeast1"
  network       = google_compute_network.vpc.id
}
