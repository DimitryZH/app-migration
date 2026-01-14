variable "project_id" {
  description = "GCP project ID for the Enterprise App Cloud Run deployment"
  type        = string
}

variable "region" {
  description = "GCP region for Cloud Run and Artifact Registry (e.g. us-central1)"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Deployment environment (e.g. dev, stage, prod)"
  type        = string
  default     = "dev"
}

variable "artifact_repo_name" {
  description = "Artifact Registry repository ID for Enterprise App container images"
  type        = string
  default     = "enterprise-app-repo"
}

variable "cloud_run_service_name" {
  description = "Cloud Run service name for the Enterprise App"
  type        = string
  default     = "enterprise-app"
}

