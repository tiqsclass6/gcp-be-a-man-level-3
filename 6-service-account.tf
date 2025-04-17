resource "google_service_account" "default" {
  account_id   = "vm-access"
  display_name = "Default VM Access Service Account"
}