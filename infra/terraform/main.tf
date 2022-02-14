


provider "yandex" {

  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}


resource "yandex_vpc_network" "this" {
  name = "1net"
}


resource "yandex_vpc_subnet" "subnet_yc_kuber" {
  name = "Project"
  network_id     = yandex_vpc_network.this.id
  zone           = var.zone
  v4_cidr_blocks = [var.v4_cidr]
}


data "yandex_compute_image" "image" {
  family = "ubuntu-1804-lts"
}




resource "yandex_vpc_address" "gitlabIP" {
  name = "GitlabIP"

  external_ipv4_address {
    zone_id = var.zone
  }
}


resource "yandex_dns_zone" "zone1" {
  name        = "yar2-zone"
  description = "desc"
  zone             = "yar2.space."
  public           = true
  
}

resource "yandex_dns_recordset" "gitlab" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "gitlab.yar2.space."
  type    = "A"
  ttl     = 60
  data    = [yandex_vpc_address.gitlabIP.external_ipv4_address.0.address]
}

output "Ext_IP_address_gitlab_yar2_space" {
  value = yandex_vpc_address.gitlabIP.external_ipv4_address.0.address
}





resource "yandex_compute_instance" "srv-gitlab" {
  name = "srv-gitlab"
  hostname = "srv-gitlab"
  zone = var.zone_app
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }


  resources {
    cores  = 8
    memory = 8
  }


  boot_disk {
    initialize_params {
      size     = 30
      type     = "network-ssd"
      image_id = data.yandex_compute_image.image.id
    }
  }


  network_interface {

    subnet_id = yandex_vpc_subnet.subnet_yc_kuber.id
    nat       = true
    nat_ip_address = yandex_vpc_address.gitlabIP.external_ipv4_address.0.address
    
  }

#waiting for machine start
  provisioner "remote-exec" {
    inline = [
    "echo"]
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].nat_ip_address
    user  = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }


   provisioner "local-exec" {
   command     = "ansible-playbook playbooks/gitlab.yml"
   working_dir = "../ansible"
  }
}



resource "yandex_compute_instance" "srv-mongodb" {
  name = "srv-mongodb"
  hostname = "srv-mongodb"
  zone = var.zone_app
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }


  resources {
    cores  = 4
    memory = 4
  }


  boot_disk {
    initialize_params {
      size     = 30
      type     = "network-ssd"
      image_id = var.mongodb_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_yc_kuber.id
    nat       = false
  }

}


