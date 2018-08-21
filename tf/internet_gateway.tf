resource "aws_internet_gateway" "internet" {
    vpc_id = "vpc-207b2446"

    tags {
        "kpn" = "itv"
        "Name" = "internet"
    }
}

