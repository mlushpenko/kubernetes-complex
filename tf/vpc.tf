resource "aws_vpc" "prod" {
    cidr_block           = "10.20.0.0/16"
    enable_dns_hostnames = false
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "prod"
        "kpn" = "itv"
    }
}

resource "aws_vpc" "blue" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = false
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "blue"
        "kpn" = "itv"
    }
}

resource "aws_vpc_peering_connection" "blue-prod" {
  peer_owner_id = "146223805486"
  peer_vpc_id   = "${aws_vpc.prod.id}"
  vpc_id        = "${aws_vpc.blue.id}"
  auto_accept   = true

  tags {
    Name = "blue-prod"
    "kpn" = "itv"
  }
}
