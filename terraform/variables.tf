variable "region" {
  description = "The name of the AWS region to set up a network within"
}

variable "cluster_name" {}

variable "base_cidr_block" {}

variable "tags" {
  type = "map"
}

provider "aws" {
  region = "${var.region}"
}
