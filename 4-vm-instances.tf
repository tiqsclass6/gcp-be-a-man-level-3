resource "google_compute_instance" "tokyo_vm" {
  name         = "tokyo-vm"
  machine_type = "e2-micro"
  zone         = var.default_zone
  tags         = ["multi-region-vm"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tokyo_subnet.name
    access_config {}
  }

  metadata_startup_script = file("japan-startup.sh")
}

resource "google_compute_instance" "sao_paulo_vm" {
  name         = "sao-paulo-vm"
  machine_type = "e2-micro"
  zone         = var.zone_sao_paulo
  tags         = ["multi-region-vm"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.sao_paulo_subnet.name
    access_config {}
  }

  metadata_startup_script = file("brazil-startup.sh")
}