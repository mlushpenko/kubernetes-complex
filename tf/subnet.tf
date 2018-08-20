resource "aws_subnet" "subnet-30b92d56-lb-backup" {
    vpc_id                  = "vpc-207b2446"
    cidr_block              = "30.0.32.0/20"
    availability_zone       = "eu-west-1b"
    map_public_ip_on_launch = false

    tags {
        "Name" = "lb-backup"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "subnet-62b56138-orange" {
    vpc_id                  = "vpc-207b2446"
    cidr_block              = "30.0.16.0/20"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = false

    tags {
        "kpn" = "itv"
        "Name" = "orange"
    }
}

resource "aws_subnet" "subnet-b58e5aef-orange-blue" {
    vpc_id                  = "vpc-70411e16"
    cidr_block              = "20.0.0.0/20"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "orange-blue"
        "kpn" = "itv"
    }
}

resource "aws_subnet" "subnet-2ebd6974-red" {
    vpc_id                  = "vpc-207b2446"
    cidr_block              = "30.0.0.0/20"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "red"
        "kpn" = "itv"
    }
}

