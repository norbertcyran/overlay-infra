resource "digitalocean_droplet" "lighthouse" {
  count = var.lighthouses-cnt

  image  = "ubuntu-20-04-x64"
  name   = "lighthouse-${format("%02d", count.index + 1)}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  tags = count.index == 0 ? ["lighthouse", "ca_authority"] : ["lighthouse"]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }
}

resource "digitalocean_floating_ip" "public-ip" {
  count = var.lighthouses-cnt

  droplet_id = digitalocean_droplet.lighthouse[count.index].id
  region     = "fra1"
}
