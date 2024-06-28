variable "project_id" {
  description = "The ID of the project in which to create the instance"
  type        = string
  default     = "devops-hq"
}

variable "region" {
  description = "The region to deploy the instance"
  type        = string
  default     = "asia-east2"
}

variable "zone" {
  description = "The zone to deploy the instance"
  type        = string
  default     = "asia-east2-b"
}
