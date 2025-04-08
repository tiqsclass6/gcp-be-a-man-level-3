resource "google_compute_firewall" "iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["multi-region-vm"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "icmp_restricted" {
  name    = "allow-internal-icmp"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1001

  source_ranges = ["10.233.40.0/24"]
  target_tags   = ["multi-region-vm"]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  direction     = "INGRESS"
  priority      = 1000
  target_tags   = ["multi-region-vm"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  description = "Allow HTTP from the internet to view startup script"
}