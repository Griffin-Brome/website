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
