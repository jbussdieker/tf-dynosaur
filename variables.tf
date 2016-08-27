variable "vpc_cidr_block" {
  description = "VPC IP block"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Subnet IP block"
  default     = "10.0.0.0/24"
}

variable "instance_type" {
  description = "Instance type (m3.medium, c4.large, etc.)"
  default     = "m3.medium"
}

variable "release" {
  description = "Ubuntu Release (precise, trusty, xenial, etc.)"
  default     = "trusty"
}

variable "virtualization_type" {
  description = "Virtualization type (hvm or paravirtual)"
  default     = "hvm"
}

variable "root_device_type" {
  description = "Root volume type (instance-store or ebs)"
  default     = "instance-store"
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = "1"
}

variable "key_name" {
  description = "Name of AWS keypair"
  type        = "string"
}

variable "region" {
  description = "Name of AWS region to launch in"
  default     = "us-west-1"
}
