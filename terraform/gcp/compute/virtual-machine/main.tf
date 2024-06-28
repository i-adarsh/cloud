provider "google" {
  project        = var.project_id
  region         = var.region
  request_reason = "creating instance using terraform"
}

resource "google_compute_instance" "default" {
  name         = "terraform-instance-2"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
