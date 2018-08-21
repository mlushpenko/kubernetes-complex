resource "aws_network_acl" "kube-master" {
    vpc_id     = "vpc-207b2446"
    subnet_ids = ["subnet-62b56138"]

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "1"
        cidr_block = "0.0.0.0/0"
        icmp_code  = "-1"
        icmp_type  = "-1"
    }

    ingress {
        from_port  = 22
        to_port    = 22
        rule_no    = 120
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.0.0/20"
    }

    ingress {
        from_port  = 179
        to_port    = 179
        rule_no    = 130
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    ingress {
        from_port  = 2379
        to_port    = 2379
        rule_no    = 135
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    ingress {
        from_port  = 6443
        to_port    = 6443
        rule_no    = 140
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    ingress {
        from_port  = 443
        to_port    = 443
        rule_no    = 145
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.0.0/16"
    }

    ingress {
        from_port  = 6443
        to_port    = 6443
        rule_no    = 150
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.0.0/16"
    }

    ingress {
        from_port  = 443
        to_port    = 443
        rule_no    = 155
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    ingress {
        from_port  = 8888
        to_port    = 8888
        rule_no    = 160
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    ingress {
        from_port  = 1024
        to_port    = 65535
        rule_no    = 200
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    ingress {
        from_port  = 32768
        to_port    = 65535
        rule_no    = 210
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 220
        action     = "allow"
        protocol   = "4"
        cidr_block = "20.0.0.0/20"
    }

    egress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "1"
        cidr_block = "0.0.0.0/0"
        icmp_code  = "-1"
        icmp_type  = "-1"
    }

    egress {
        from_port  = 22
        to_port    = 22
        rule_no    = 110
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    egress {
        from_port  = 80
        to_port    = 80
        rule_no    = 120
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        from_port  = 179
        to_port    = 179
        rule_no    = 130
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    egress {
        from_port  = 443
        to_port    = 443
        rule_no    = 140
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        from_port  = 10250
        to_port    = 10250
        rule_no    = 150
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    egress {
        from_port  = 1024
        to_port    = 65535
        rule_no    = 160
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.0.0/16"
    }

    egress {
        from_port  = 1024
        to_port    = 65535
        rule_no    = 165
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    egress {
        from_port  = 32768
        to_port    = 65535
        rule_no    = 200
        action     = "allow"
        protocol   = "6"
        cidr_block = "20.0.0.0/20"
    }

    egress {
        from_port  = 32768
        to_port    = 65535
        rule_no    = 210
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.0.0/16"
    }

    egress {
        from_port  = 0
        to_port    = 0
        rule_no    = 220
        action     = "allow"
        protocol   = "4"
        cidr_block = "20.0.0.0/20"
    }

    tags {
        "Name" = "kube-master"
        "kpn" = "itv"
    }
}

resource "aws_network_acl" "public" {
    vpc_id     = "vpc-207b2446"
    subnet_ids = ["subnet-2ebd6974"]

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "1"
        cidr_block = "0.0.0.0/0"
        icmp_code  = "-1"
        icmp_type  = "-1"
    }

    ingress {
        from_port  = 22
        to_port    = 22
        rule_no    = 110
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    ingress {
        from_port  = 80
        to_port    = 80
        rule_no    = 120
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    ingress {
        from_port  = 443
        to_port    = 443
        rule_no    = 130
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    ingress {
        from_port  = 1024
        to_port    = 65535
        rule_no    = 140
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        from_port  = 0
        to_port    = 0
        rule_no    = 110
        action     = "allow"
        protocol   = "1"
        cidr_block = "0.0.0.0/0"
        icmp_code  = "-1"
        icmp_type  = "-1"
    }

    egress {
        from_port  = 22
        to_port    = 22
        rule_no    = 120
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 80
        to_port    = 80
        rule_no    = 130
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        from_port  = 443
        to_port    = 443
        rule_no    = 140
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    egress {
        from_port  = 6443
        to_port    = 6443
        rule_no    = 150
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 32768
        to_port    = 65535
        rule_no    = 160
        action     = "allow"
        protocol   = "6"
        cidr_block = "0.0.0.0/0"
    }

    tags {
        "Name" = "public"
        "kpn" = "itv"
    }
}

resource "aws_network_acl" "kube-node" {
    vpc_id     = "vpc-70411e16"
    subnet_ids = ["subnet-b58e5aef"]

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "1"
        cidr_block = "30.0.16.0/20"
        icmp_code  = "-1"
        icmp_type  = "-1"
    }

    ingress {
        from_port  = 22
        to_port    = 22
        rule_no    = 110
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    ingress {
        from_port  = 179
        to_port    = 179
        rule_no    = 120
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    ingress {
        from_port  = 10250
        to_port    = 10250
        rule_no    = 130
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    ingress {
        from_port  = 30000
        to_port    = 32767
        rule_no    = 200
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    ingress {
        from_port  = 32768
        to_port    = 65535
        rule_no    = 210
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    ingress {
        from_port  = 0
        to_port    = 0
        rule_no    = 220
        action     = "allow"
        protocol   = "4"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 0
        to_port    = 0
        rule_no    = 100
        action     = "allow"
        protocol   = "1"
        cidr_block = "30.0.16.0/20"
        icmp_code  = "-1"
        icmp_type  = "-1"
    }

    egress {
        from_port  = 179
        to_port    = 179
        rule_no    = 110
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 2379
        to_port    = 2379
        rule_no    = 125
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 6443
        to_port    = 6443
        rule_no    = 130
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 8888
        to_port    = 8888
        rule_no    = 140
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 32768
        to_port    = 65535
        rule_no    = 220
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 0
        to_port    = 0
        rule_no    = 250
        action     = "allow"
        protocol   = "4"
        cidr_block = "30.0.16.0/20"
    }

    egress {
        from_port  = 443
        to_port    = 443
        rule_no    = 260
        action     = "allow"
        protocol   = "6"
        cidr_block = "30.0.16.0/20"
    }

    tags {
        "Name" = "kube-node"
        "kpn" = "itv"
    }
}
