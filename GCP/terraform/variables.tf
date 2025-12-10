variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "instance_type" {
  description = "The machine type for the instances"
  type        = string
  default     = "e2-micro"
}

variable "image_family" {
  description = "The image family for the OS"
  type        = string
  default     = "debian-11"
}

variable "image_project" {
  description = "The project for the OS image"
  type        = string
  default     = "debian-cloud"
}

variable "flask_secret" {
  description = "Secret key for Flask app"
  type        = string
  default     = "something-random-change-me"
}