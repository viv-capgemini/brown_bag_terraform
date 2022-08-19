variable "region" {
  description = "AWS London region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24","10.0.3.0/24"]
}


variable "public_subnets" {
  description = "Private Subnets"
  type        = list(string)
  default     = ["10.0.2.0/24","10.0.4.0/24"]
}