resource "aws_security_group" "kubernetes" {
    name = "kubernetes-${var.cluster_name}-securitygroup"
    vpc_id = "${aws_vpc.cluster-vpc.id}"

    tags = "${merge(var.tags, map(
      "Name", "kubernetes-${var.cluster_name}-securitygroup"
    ))}"
}

resource "aws_security_group_rule" "allow-all-ingress" {
    type = "ingress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks= ["${var.aws_vpc_cidr_block}"]
    security_group_id = "${aws_security_group.kubernetes.id}"
}

resource "aws_security_group_rule" "allow-all-egress" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.kubernetes.id}"
}


resource "aws_security_group_rule" "allow-ssh-connections" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.kubernetes.id}"
}
