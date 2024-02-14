variable "cidr_paris" {
  default     = ""
  description = "CIDR de Paris"
  type        = string
  sensitive   = false
}

/* variable "cidr_subnet_public" {
    default = ""
    description = "CIDR de la subred publica"
    type = string
    sensitive = false
}

variable "cidr_subnet_private" {
    default = ""
    description = "CIDR de la subred privada"
    type = string
    sensitive = false
} */

variable "subnets" {
  description = "values for subnets"
  type        = map(string)
}

variable "tags" {
  description = "tags for subnets"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "instance_type" {
  description = "Type of instance"
  type        = string
}

variable "ami_value" {
  description = "AMI value"
  type        = string
}

variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = bool
}

variable "ingress_port_list" {
  description = "List of ingress ports"
  type        = list(number)
}