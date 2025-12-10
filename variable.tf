variable "region" {
    description = "AWS region"
    type = string
}

variable "key_name" {
    description = "key name pair"
    type = string
}

variable "sg_id" {
    description = "Default security group"
    type = string
}

variable "instance_type" {
    description = "Type of instance"
    type = string
}

variable "subnet_id" {
    description = "Subnet"
    type = string
}

variable "private_ip" {
    description = "private ip address"
    type = string
}

variable "availability_zone" {
    description = "Availability zone"
    type = string
}

variable "vpc_id" {
    description = "vpc id"
    type = string
}

