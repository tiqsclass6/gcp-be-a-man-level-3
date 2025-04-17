provider "google" {
  credentials = "<path/to/service-account.json>" # Insert your json credential here
  project     = var.project_id
  region      = "us-central1"
  zone        = var.iowa_zone
}