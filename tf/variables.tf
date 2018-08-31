variable "masters_count" {
  default = 3
}

variable "workers_count" {
  default = 2
}

variable "mgmt_os" {
  default = "ubuntu16.04"
}

variable "k8s_os" {
  default = "rhel7.5"
}

variable "amis" {
  type "map"
  default = {
    "ubuntu16.04" = "ami-0181f8d9b6f098ec4"
    "rhel7.5"     = "ami-7c491f05"
  }
}