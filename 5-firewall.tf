# HTTP: Iowa ➝ Brazil Web (Port 80)
resource "google_compute_firewall" "http-iowa-to-brazil" {
  name          = "http-iowa-to-brazil"
  network       = google_compute_network.vpc.name
  direction     = "INGRESS"
  source_tags   = ["iowa-rdp"]
  target_tags   = ["brazil-web"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  priority = 998
}

# HTTP: Brazil Web ➝ Tokyo Web (Port 80)
resource "google_compute_firewall" "http-brazil-to-tokyo" {
  name          = "http-brazil-to-tokyo"
  network       = google_compute_network.vpc.name
  direction     = "INGRESS"
  source_tags   = ["brazil-rdp"]
  target_tags   = ["tokyo-web"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  priority = 999
}

# Public RDP: Internet ➝ Sao Paulo RDP (Port 3389)
resource "google_compute_firewall" "rdp-public-brazil" {
  name          = "rdp-public-brazil"
  network       = google_compute_network.vpc.name
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["brazil-rdp"]

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  priority = 1000
}


# Public RDP: Internet ➝ Iowa RDP (Port 3389)
resource "google_compute_firewall" "rdp-public-iowa" {
  name          = "rdp-public-iowa"
  network       = google_compute_network.vpc.name
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["iowa-rdp"]

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  priority = 1000
}