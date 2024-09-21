output "project_id" {
  description = "The project ID of the created project"
  value       = google_project.project.project_id
}

output "project_name" {
  description = "The name of the created project"
  value       = google_project.project.name
}

