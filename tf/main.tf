terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "terraform" {
  name       = "terraform"
  public_key = file("${var.ssh_key}.pub")
}

resource "digitalocean_droplet" "www" {
  image     = "ubuntu-24-04-x64"
  name      = "www"
  region    = var.region
  size      = "s-1vcpu-1gb"
  user_data = data.cloudinit_config.cloudinit.rendered
  ssh_keys = [
    digitalocean_ssh_key.terraform.id
  ]
}

resource "digitalocean_domain" "www" {
  name       = var.domain_name
  ip_address = digitalocean_droplet.www.ipv4_address
}


data "cloudinit_config" "cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content = templatefile(
      "${path.module}/cloud-config.yaml.tftpl",
      { domain_name = var.domain_name }
    )
  }

  part {
    filename     = "write-files"
    content_type = "text/cloud-config"
    content = yamlencode(
      {
        "write_files" : [
          {
            "path" : "/etc/caddy/Caddyfile",
            "content" : templatefile(
              "${path.module}/Caddyfile.tftpl",
              { domain_name = var.domain_name }
            )
          }
        ]
      }
    )
  }
}
