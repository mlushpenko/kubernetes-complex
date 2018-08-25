resource "aws_eip" "nat" {
    vpc               = true

    tags {
        "kpn" = "itv"
    }
}

resource "aws_nat_gateway" "proxy" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.blue-red.id}"
    tags {
        "kpn" = "itv"
    }

    depends_on = ["aws_internet_gateway.internet"]
}

