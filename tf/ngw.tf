resource "aws_eip" "eipalloc-85fcdbb8" {
    network_interface = "eni-efa89be9"
    vpc               = true

    tags {
        "kpn" = "itv"
    }
}

resource "aws_nat_gateway" "nat-0bd0873aaed6ca82d" {
    allocation_id = "eipalloc-85fcdbb8"
    subnet_id = "subnet-2ebd6974"
    tags {
        "kpn" = "itv"
    }
}

