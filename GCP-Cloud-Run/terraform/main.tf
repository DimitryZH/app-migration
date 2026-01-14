terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

############################
## Core Infrastructure
############################

# Artifact Registry repository for Enterprise App containers
resource "google_artifact_registry_repository" "enterprise_app" {
  provider = google-beta

  location      = var.region
  repository_id = var.artifact_repo_name
  description   = "Artifact Registry repo for Enterprise App Cloud Run images"
  format        = "DOCKER"
}

# Service Account used by Cloud Run to access GCP services
resource "google_service_account" "enterprise_app" {
  account_id   = "enterprise-app-sa"
  display_name = "Enterprise App Cloud Run Service Account"
}

# IAM roles for the Enterprise App service account

resource "google_project_iam_member" "enterprise_app_datastore" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.enterprise_app.email}"
}

resource "google_project_iam_member" "enterprise_app_storage" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.enterprise_app.email}"
}

resource "google_project_iam_member" "enterprise_app_secretmanager" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.enterprise_app.email}"
}

############################
## Cloud Run (skeleton)
############################

# NOTE:
# The Cloud Run service definition will be wired to an image
# produced by CI/CD (GitHub Actions) and pushed to Artifact Registry.
# For now we create a minimal service pointing at a placeholder image.

resource "google_cloud_run_v2_service" "enterprise_app" {
  name     = var.cloud_run_service_name
  location = var.region

  template {
    service_account = google_service_account.enterprise_app.email

    containers {
      # Placeholder image; will be overridden by CI/CD to an
      # image in the enterprise-app Artifact Registry repository.
      image = "us-docker.pkg.dev/cloudrun/container/hello"

      ports {
        container_port = 8080
      }

      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 5
    }
  }

  ingress = "INGRESS_TRAFFIC_ALL"

  lifecycle {
    ignore_changes = [
      # allow CI/CD to update the image without constantly
      # forcing Terraform drift
      template[0].containers[0].image,
    ]
  }
}

