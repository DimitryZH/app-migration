output "artifact_registry_repository" {
  description = "Artifact Registry repository resource for Enterprise App images"
  value       = google_artifact_registry_repository.enterprise_app.id
}

output "cloud_run_service_name" {
  description = "Name of the Enterprise App Cloud Run service"
  value       = google_cloud_run_v2_service.enterprise_app.name
}

output "cloud_run_service_location" {
  description = "Region of the Enterprise App Cloud Run service"
  value       = google_cloud_run_v2_service.enterprise_app.location
}

output "cloud_run_service_uri" {
  description = "Public URI of the Enterprise App Cloud Run service"
  value       = google_cloud_run_v2_service.enterprise_app.uri
}

