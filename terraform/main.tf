terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.19"
    }
  }
}

variable "do_token" {}
variable "do_ssh_key" {}
variable "pvt_key" {}
variable "lighthouses-cnt" {
  default = 1
}
variable "hosts-cnt" {
  default = 2
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = var.do_ssh_key
}