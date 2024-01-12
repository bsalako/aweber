variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}
variable "vpc_tag_name" {
  type        = string
  description = "VPC tag name"
  default     = "eks-vpc"
}
variable "availability_zones" {
  type = list(string)
}
variable "route_table_tag_name" {
  type        = string
  description = "eks"
}
variable "private_subnet_tag_name" {
  type        = string
  description = "private subnet tag name"
}
variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "private subnet cidr blocks"
}
variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "private subnet cidr blocks"
}
variable "public_subnet_tag_name" {
  type        = string
  description = "public subnet tag name"
}
variable "eks_cluster_name" {
  type = string
}