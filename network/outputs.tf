output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = var.vpc_cidr
}

output "private_subnets" {
  description = "private_subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "public_subnets"
  value       = module.vpc.public_subnets
}