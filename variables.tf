variable "project_name" {
  type    = string
  default = "my-three-tier-app"
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}