resource "aws_subnet" "lb-backup" {
    vpc_id                  = "${aws_vpc.blue.id}"
    cidr_block              = "30.0.48.0/20"
    map_public_ip_on_launch = false

    tags {
        "Name" = "lb-backup"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "blue-red" {
    vpc_id                  = "${aws_vpc.blue.id}"
    cidr_block              = "30.0.0.0/20"
    map_public_ip_on_launch = false

    tags {
        "Name" = "blue-red"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "blue-orange" {
    vpc_id                  = "${aws_vpc.blue.id}"
    cidr_block              = "30.0.16.0/20"
    map_public_ip_on_launch = false

    tags {
        "kpn" = "itv"
        "Name" = "blue-orange"
    }
}

resource "aws_subnet" "blue-green" {
    vpc_id                  = "${aws_vpc.blue.id}"
    cidr_block              = "30.0.32.0/20"
    map_public_ip_on_launch = false

    tags {
        "Name" = "blue-green"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "red-blue" {
    vpc_id                  = "${aws_vpc.prod.id}"
    cidr_block              = "20.0.0.0/20"
    map_public_ip_on_launch = false

    tags {
        "Name" = "red-blue"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "orange-blue" {
    vpc_id                  = "${aws_vpc.prod.id}"
    cidr_block              = "20.0.16.0/20"
    map_public_ip_on_launch = false

    tags {
        "Name" = "orange-blue"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "green-blue" {
    vpc_id                  = "${aws_vpc.prod.id}"
    cidr_block              = "20.0.32.0/20"
    map_public_ip_on_launch = false

    tags {
        "Name" = "green-blue"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "red-prod" {
    vpc_id                  = "${aws_vpc.prod.id}"
    cidr_block              = "20.0.48.0/20"
    map_public_ip_on_launch = false
    availability_zone       = "${aws_subnet.red-blue.availability_zone}"

    tags {
        "Name" = "red-prod"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "orange-prod" {
    vpc_id                  = "${aws_vpc.prod.id}"
    cidr_block              = "20.0.64.0/20"
    map_public_ip_on_launch = false
    availability_zone       = "${aws_subnet.orange-blue.availability_zone}"

    tags {
        "Name" = "orange-prod"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "green-prod" {
    vpc_id                  = "${aws_vpc.prod.id}"
    cidr_block              = "20.0.80.0/20"
    map_public_ip_on_launch = false
    availability_zone       = "${aws_subnet.green-blue.availability_zone}"
    tags {
        "Name" = "green-prod"
        "kpn" = "itv"
    }
}

