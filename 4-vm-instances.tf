resource "google_compute_instance" "iowa_vm" {
  name         = "iowa-rdp"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"
  tags         = ["iowa-rdp"]

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2025-dc-v20250416"
      size  = 50
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.iowa_subnet.id
    access_config {
      nat_ip = google_compute_address.iowa_static_ip.address
    }
  }
}

resource "google_compute_instance" "brazil_linux_vm" {
  name         = "brazil-web"
  machine_type = "e2-medium"
  zone         = "southamerica-east1-a"
  tags         = ["brazil-web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.brazil_subnet.id
    access_config {
      nat_ip = google_compute_address.brazil_linux_static_ip.address
    }
  }

  metadata_startup_script = file("brazil-startup.sh")

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "brazil_windows_vm" {
  name         = "brazil-rdp"
  machine_type = "n2-standard-2"
  zone         = "southamerica-east1-a"
  tags         = ["brazil-rdp"]

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2025-dc-v20250416"
      size  = 50
      type  = "pd-balanced"
    }
  }

  network_interface {
  subnetwork = google_compute_subnetwork.brazil_subnet.id
  access_config {
    nat_ip = google_compute_address.brazil_windows_static_ip.address
  }
  }
}

resource "google_compute_instance" "tokyo_vm" {
  name         = "tokyo-web"
  machine_type = "e2-medium"
  zone         = "asia-northeast1-a"
  tags         = ["tokyo-web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tokyo_subnet.id
    access_config {
      nat_ip = google_compute_address.tokyo_static_ip.address
    }
  }

  metadata_startup_script = file("japan-startup.sh")

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}