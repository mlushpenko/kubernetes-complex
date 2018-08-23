resource "aws_route_table" "prod" {
    vpc_id     = "vpc-70411e16"

    route {
        cidr_block = "${aws_instance.proxy.private_ip}/32" # proxy server IP which is located in
        vpc_peering_connection_id = "pcx-bc43b2d4"
    }

    route {
        cidr_block = "30.0.16.0/20"
        vpc_peering_connection_id = "pcx-bc43b2d4"
    }

    tags {
        "Name" = "prod"
        "kpn" = "itv"
    }
}

resource "aws_route_table" "blue-orange" {
    vpc_id     = "vpc-207b2446"

    route {
        cidr_block = "20.0.0.0/20"
        vpc_peering_connection_id = "pcx-bc43b2d4"
    }

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "nat-0bd0873aaed6ca82d"
    }

    tags {
        "kpn" = "itv"
        "Name" = "blue-orange"
    }
}

resource "aws_route_table" "blue-red" {
    vpc_id     = "vpc-207b2446"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-5e3e6b39"
    }

    tags {
        "Name" = "blue-red"
        "kpn" = "itv"
    }
}

