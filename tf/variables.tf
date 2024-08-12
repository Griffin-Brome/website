variable "do_token" {
  description = "Digital Ocean API Token"
}

variable "ssh_key" {
  description = "Path to SSH Public Key to Provide to VM"
  default     = "~/.ssh/id_ed25519"
}

variable "region" {
  description = "Digital Ocean Region"
  default     = "sfo1"
}

variable "certbot_do_token" {
  description = "Digital Ocean API Token to use for DNS-01 Challenges"
}

variable "domain_name" {
  description = "Site domain name"
}

variable "ssl_renew_email" {
  description = "Email that Certbot will use for SSL Renewal Alerts"
}
