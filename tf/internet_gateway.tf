resource "aws_internet_gateway" "internet" {
    vpc_id = "${aws_vpc.blue.id}"

    tags {
        "kpn" = "itv"
        "Name" = "internet"
    }
}

