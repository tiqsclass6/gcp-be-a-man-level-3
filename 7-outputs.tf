output "iowa_vm_internal_ip" {
  value       = google_compute_instance.iowa_vm.network_interface[0].network_ip
  description = "Internal IP address of the Iowa RDP VM"
}

output "iowa_vm_external_ip" {
  value       = google_compute_address.iowa_static_ip.address
  description = "Static external IP of the Iowa RDP VM"
}

output "brazil_linux_vm_internal_ip" {
  value       = google_compute_instance.brazil_linux_vm.network_interface[0].network_ip
  description = "Internal IP address of the Brazil Linux Web VM"
}

output "brazil_linux_vm_external_ip" {
  value       = google_compute_address.brazil_linux_static_ip.address
  description = "Static external IP of the Brazil Linux Web VM"
}

output "brazil_windows_vm_internal_ip" {
  value       = google_compute_instance.brazil_windows_vm.network_interface[0].network_ip
  description = "Internal IP address of the Brazil Windows RDP VM"
}

output "brazil_windows_vm_external_ip" {
  value       = google_compute_address.brazil_windows_static_ip.address
  description = "Static external IP of the Brazil Windows RDP VM"
}

output "tokyo_vm_internal_ip" {
  value       = google_compute_instance.tokyo_vm.network_interface[0].network_ip
  description = "Internal IP address of the Tokyo Linux Web VM"
}

output "tokyo_vm_external_ip" {
  value       = google_compute_address.tokyo_static_ip.address
  description = "Static external IP of the Tokyo Linux Web VM"
}