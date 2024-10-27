variable "env" {}
variable "tags" {}

# Locals Variables
variable "elasticache_type" {
  description = "Type of ElastiCache (e.g., redis or memcached)."
}


# Subnet Group
variable "db_subnets" {
  description = "List of subnet IDs for the ElastiCache subnet group."
}

# PG
variable "engine_family" {
  description = "Engine family for the ElastiCache parameter group (e.g., redis or memcached)."
}


# SG
variable "vpc_id" {
  description = "ID of the VPC where the SG resources will be created."
}

variable "app_subnets_cidr" {
  description = "CIDR blocks of the application subnets allowed to access ElastiCache."
}

variable "port" {
  description = "Port number for ElastiCache (e.g., 6379 for Redis)."
}