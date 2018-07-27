resource "aws_security_group" "aws-elb" {
    name = "kubernetes-${var.cluster_name}-securitygroup-elb"
    vpc_id = "${var.aws_vpc_id}"

    tags = "${merge(var.tags, map(
      "Name", "kubernetes-${var.cluster_name}-securitygroup-elb"
    ))}"
}


resource "aws_security_group_rule" "aws-allow-api-access" {
    type = "ingress"
    from_port = "${var.aws_elb_api_port}"
    to_port = "${var.k8s_secure_api_port}"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.aws-elb.id}"
}

resource "aws_security_group_rule" "aws-allow-api-egress" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.aws-elb.id}"
}
