variable "db_username" {
  description = "Username for the backend DB"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "Password for the backend DB"
  type = string
  sensitive = true
}