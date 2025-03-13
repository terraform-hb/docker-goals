variable "mongo_db_password" {
  description = "MongoDB connection password"
  type        = string
  sensitive   = true
}

variable "mongo_db_username" {
  description = "MongoDB connection usrename"
  type        = string
  sensitive   = false
}

variable "mongo_db_host" {
  description = "MongoDB connection cluster host"
  type        = string
  sensitive   = false
}
