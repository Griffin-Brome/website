data "template_file" "user_data" {
  template = file("./user-data")
}

resource "digitalocean_droplet" "www" {
  image     = "ubuntu-24-04-x64"
  name      = "www"
  region    = var.region
  size      = "s-1vcpu-2gb"
  user_data = data.template_file.user_data.rendered
  ssh_keys  = [
      digitalocean_ssh_key.terraform.id
  ]
}

output "public_ip" {
  value = digitalocean_droplet.www.ipv4_address
}

output "ssh_key" {
  value = var.ssh_key
}
