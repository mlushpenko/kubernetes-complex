resource "aws_route_table" "blue-red" {
    vpc_id     = "${aws_vpc.blue.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.internet.id}"
    }

    tags {
        "Name" = "blue-red"
        "kpn" = "itv"
    }
}

resource "aws_route_table" "blue-orange" {
    vpc_id     = "${aws_vpc.blue.id}"

    route {
        cidr_block = "${aws_subnet.red-blue.cidr_block}"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.blue-prod.id}"
    }

    route {
        cidr_block = "${aws_subnet.orange-blue.cidr_block}"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.blue-prod.id}"
    }

    route {
        cidr_block = "${aws_subnet.green-blue.cidr_block}"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.blue-prod.id}"
    }

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.proxy.id}"
    }

    tags {
        "kpn" = "itv"
        "Name" = "blue-orange"
    }
}

resource "aws_route_table" "blue-green" {
    vpc_id     = "${aws_vpc.blue.id}"

    tags {
        "Name" = "blue-green"
        "kpn" = "itv"
    }
}

resource "aws_route_table" "prod-blue" {
    vpc_id     = "${aws_vpc.prod.id}"

    route {
        cidr_block = "${aws_instance.proxy.private_ip}/32" # proxy server IP which is located in
        vpc_peering_connection_id = "${aws_vpc_peering_connection.blue-prod.id}"
    }

    route {
        cidr_block = "${aws_subnet.blue-orange.cidr_block}"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.blue-prod.id}"
    }

    tags {
        "Name" = "prod-blue"
        "kpn" = "itv"
    }
}

resource "aws_route_table_association" "blue-red" {
    route_table_id = "${aws_route_table.blue-red.id}"
    subnet_id = "${aws_subnet.blue-red.id}"
}

resource "aws_route_table_association" "blue-orange" {
    route_table_id = "${aws_route_table.blue-orange.id}"
    subnet_id = "${aws_subnet.blue-orange.id}"
}

resource "aws_route_table_association" "blue-orange-lb" {
    route_table_id = "${aws_route_table.blue-orange.id}"
    subnet_id = "${aws_subnet.lb-backup.id}"
}

resource "aws_route_table_association" "blue-green" {
    route_table_id = "${aws_route_table.blue-green.id}"
    subnet_id = "${aws_subnet.blue-green.id}"
}

resource "aws_route_table_association" "red-blue" {
    route_table_id = "${aws_route_table.prod-blue.id}"
    subnet_id = "${aws_subnet.red-blue.id}"
}

resource "aws_route_table_association" "orange-blue" {
    route_table_id = "${aws_route_table.prod-blue.id}"
    subnet_id = "${aws_subnet.orange-blue.id}"
}

resource "aws_route_table_association" "green-blue" {
    route_table_id = "${aws_route_table.prod-blue.id}"
    subnet_id = "${aws_subnet.green-blue.id}"
}