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


variable "cluster_version" {
  description = "cluster version"
  type        = string
  default     = "1.23"
}


variable "instance_type" {
  description = "instance type"
  type        = list(string)
  default     = ["t3.small"]
}