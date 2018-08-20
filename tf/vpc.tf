resource "aws_vpc" "prod" {
    cidr_block           = "20.0.0.0/16"
    enable_dns_hostnames = false
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "prod"
        "kpn" = "itv"
    }
}

resource "aws_vpc" "blue" {
    cidr_block           = "30.0.0.0/16"
    enable_dns_hostnames = false
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "blue"
        "kpn" = "itv"
    }
}

