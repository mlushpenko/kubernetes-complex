resource "aws_security_group" "elb-k8s" {
    name        = "elb-k8s"
    description = "kuberentes"
    vpc_id      = "${aws_vpc.blue.id}"

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "K8s API access behind load balancer"
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "kpn" = "itv"
        "Name" = "k8s-lb"
    }
}

resource "aws_security_group" "kube-master" {
    name        = "kube-master"
    description = "Kubernetes master ports"
    vpc_id      = "${aws_vpc.blue.id}"

    ingress {
        from_port       = 6443
        to_port         = 6443
        protocol        = "tcp"
        cidr_blocks     = ["${aws_subnet.orange-blue.cidr_block}", "${aws_vpc.blue.cidr_block}"]
        description     = "Prod-orange and blue-red to k8s api"
    }

    ingress {
        from_port       = 2379
        to_port         = 2379
        protocol        = "tcp"
        cidr_blocks     = ["${aws_subnet.orange-blue.cidr_block}"]
        description     = "ETCD access for Calico"
    }

    ingress {
        from_port       = 179
        to_port         = 179
        protocol        = "tcp"
        cidr_blocks     = ["${aws_subnet.orange-blue.cidr_block}"]
        description     = "Calico BGP protocol"
    }

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "4"
        cidr_blocks     = ["${aws_subnet.orange-blue.cidr_block}"]
        description     = "IPIP for pod network"
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "kpn" = "itv"
        "Name" = "kube-master"
    }
}

resource "aws_security_group" "basic-prod" {
    name        = "basic-prod"
    description = "ssh and ping access"
    vpc_id      = "${aws_vpc.prod.id}"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["${aws_vpc.blue.cidr_block}"]
        description     = "SSH access from blue-orange"
    }

    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "PING for basic checks"
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "kpn" = "itv"
        "Name" = "basic-prod"
    }
}

resource "aws_security_group" "basic-blue" {
    name        = "basic-blue"
    description = "ssh and ping connectivity"
    vpc_id      = "${aws_vpc.blue.id}"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "SSH access from anywhere"
    }

    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "PING for basic checks"
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "basic-blue"
        "kpn" = "itv"
    }
}

resource "aws_security_group" "proxy" {
    name        = "proxy"
    description = "Proxy ports"
    vpc_id      = "${aws_vpc.blue.id}"

    ingress {
        from_port       = 8888
        to_port         = 8888
        protocol        = "tcp"
        cidr_blocks     = ["${aws_vpc.prod.cidr_block}", "${aws_subnet.blue-orange.cidr_block}"]
        description     = "HTTP proxy access"
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "kpn" = "itv"
        "Name" = "proxy"
    }
}

resource "aws_security_group" "kube-node" {
    name        = "kube-node"
    description = "Kubernetes node ports"
    vpc_id      = "${aws_vpc.prod.id}"

    ingress {
        from_port       = 10250
        to_port         = 10250
        protocol        = "tcp"
        cidr_blocks     = ["${aws_subnet.blue-orange.cidr_block}"]
        description     = "kube-api to kubelet"
    }

    ingress {
        from_port       = 179
        to_port         = 179
        protocol        = "tcp"
        cidr_blocks     = ["${aws_subnet.blue-orange.cidr_block}"]
        description     = "Calico BGP protocol"
    }

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "4"
        cidr_blocks     = ["${aws_subnet.blue-orange.cidr_block}"]
        description     = "Calico IPIP"
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "kube-node"
        "kpn" = "itv"
    }
}

