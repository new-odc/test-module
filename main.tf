provider "google" {
  credentials = file(var.credentials_file_path)  # Path to service account key
  region      = var.region
}

# Generate a random project ID using epoch time
locals {
  epoch_time = floor(timeadd(timestamp(), 0) / 1000)
  project_id = "${var.project_name}-${local.epoch_time}"
}

resource "google_project" "project" {
  name       = var.project_name
  project_id = local.project_id  # Use the generated project ID
  org_id     = var.organization_id
  folder_id  = var.folder_id
}

resource "google_project_service" "services" {
  for_each = toset(var.activate_apis)
  project  = google_project.project.project_id
  service  = each.value
}

resource "google_compute_shared_vpc_service_project" "service_project" {
  project     = google_project.project.project_id
  host_project = var.svpc_host_project_id
}

resource "google_compute_subnetwork_iam_member" "subnet_roles" {
  for_each = toset(var.shared_vpc_subnets)
  subnetwork = each.value
  project    = var.svpc_host_project_id
  region     = var.region
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${google_project.project.project_id}@${google_project.project.project_id}.iam.gserviceaccount.com"
}

