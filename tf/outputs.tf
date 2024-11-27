output "public_ip" {
  value = digitalocean_droplet.www.ipv4_address
}

output "ssh_key" {
  value = var.ssh_key
}

output "url" {
  value = "https://${var.domain_name}"
}
