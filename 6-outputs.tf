output "tokyo_vm_internal_ip" {
  value = google_compute_instance.tokyo_vm.network_interface[0].network_ip
}

output "sao_paulo_vm_internal_ip" {
  value = google_compute_instance.sao_paulo_vm.network_interface[0].network_ip
}