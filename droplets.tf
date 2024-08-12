resource "digitalocean_droplet" "www" {
  image     = "ubuntu-24-04-x64"
  name      = "www"
  region    = var.region
  size      = "s-1vcpu-2gb"
  user_data = templatefile(
    "${path.module}/templates/user-data.tftpl",
    {
      certbot_do_token  = var.certbot_do_token,
      ssl_renew_email   = var.ssl_renew_email,
      domain_name       = var.domain_name
    }
  )
  ssh_keys  = [
      digitalocean_ssh_key.terraform.id
  ]
}

resource "digitalocean_domain" "www" {
  name       = var.domain_name
  ip_address = digitalocean_droplet.www.ipv4_address 
}

output "public_ip" {
  value = digitalocean_droplet.www.ipv4_address
}

output "ssh_key" {
  value = var.ssh_key
}
