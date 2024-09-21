variable "project_name" {
  description = "The name of the project you are creating"
  type        = string
}

variable "organization_id" {
  description = "The organization ID to create the project under"
  type        = string
}

variable "folder_id" {
  description = "The folder ID to organize the project under"
  type        = string
}

variable "svpc_host_project_id" {
  description = "The ID of the Shared VPC host project"
  type        = string
}

variable "shared_vpc_subnets" {
  description = "A list of Shared VPC subnets to use"
  type        = list(string)
}

variable "activate_apis" {
  description = "A list of APIs to activate in the project"
  type        = list(string)
  default     = ["compute.googleapis.com", "servicenetworking.googleapis.com"]
}

variable "region" {
  description = "The region where the Shared VPC subnets are located"
  type        = string
}

