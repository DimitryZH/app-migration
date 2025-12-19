resource "google_compute_instance_template" "app_template" {
  name_prefix  = "employee-web-app-template-"
  machine_type = var.instance_type
  region       = var.region

  disk {
    source_image = "${var.image_project}/${var.image_family}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id
  }

  service_account {
    email  = google_service_account.app_service_account.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = templatefile("startup.sh", {
    bucket_name  = google_storage_bucket.employee_photo_bucket.name
    project_id   = var.project_id
    flask_secret = var.flask_secret
  })

  tags = ["http-server"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "app_mig" {
  name               = "employee-web-app-mig"
  base_instance_name = "employee-web-app"
  region             = var.region
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.app_template.id
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    port = 80
  }
}

resource "google_compute_region_autoscaler" "app_autoscaler" {
  name   = "employee-web-app-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.app_mig.id

  autoscaling_policy {
    max_replicas    = 4
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}