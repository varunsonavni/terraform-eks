variable "eks_version" {
    type = string
    default = "17.24.0"
}

variable "env" {
    type = string
    default = "stage"
}
variable "cluster_name" {
    type = string
    default = "Cluster"
}
variable "worker_group_name" {
    type = string
    default = "worker-group"
}

variable "cluster_version" {
    type = string
    default = "1.25"
}

variable "worker_instance"{
    type = string
    default = "t2.micro"
}

variable "worker_desired_capacity" {
    type = number
    default = 1
}

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}


variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

}
variable "vpc_public_subnets" {
  type = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

}

variable "ports" {
  type = list(number)
  default = [22, 80, 443]
}

variable "sg_ingress_cidr_block_worker_group_mgmt_one" {
  type = list(string)
  default = ["10.0.0.0/8"]
}

variable "sg_ingress_cidr_block_worker_group_mgmt_two" {
  type = list(string)
  default = ["192.168.0.0/16"]
}
variable "sg_ingress_cidr_block_all_worker_mgmt" {
  type = list(string)
  default = ["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16"]
}

variable "root_volume_type" {
  type = string
  default = "gp3"
}

variable "asg_min_size" {
  type = number
  default = 1
}

variable "asg_max_size" {
  type = number
  default = 1
}

variable "key_name" {
  type = string
  default = "wwww"
}

variable "launch_template_name" {
    type = string
    default = "Launch-template"
}

variable "root_volume_size"{
  type = string
  default = "60"
}
