data "aws_subnet_ids" "orange" {
  vpc_id = "${var.vpc_id}"

  tags {
    VPC = "Blue"
    Subnet = "Orange"
  }
}

data "aws_subnet" "orange" {
  count = "${length(data.aws_subnet_ids.orange.ids)}"
  id = "${data.aws_subnet_ids.orange.ids[count.index]}"
}

resource "aws_network_acl" "orange" {
  vpc_id = "${var.vpc_id}"
  subnet_ids = ["${data.aws_subnet_ids.orange.ids}"]
}

# Rules

# etcd
# inbound
resource "aws_network_acl_rule" "orange_to_etcd" {
  network_acl_id = "${aws_network_acl.orange.id}"
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${element(data.aws_subnet.orange.*.cidr_block, count.index)}"
  from_port      = 2379 # client request
  to_port        = 2380 # peer communication

  count = "${length(data.aws_subnet.orange.count)}"
}
# outbound
resource "aws_network_acl_rule" "etcd_to_orange" {
  network_acl_id = "${aws_network_acl.orange.id}"
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${element(data.aws_subnet.orange.*.cidr_block, count.index)}"
  from_port      = 2379 # client request
  to_port        = 2380 # peer communication

  count = "${length(data.aws_subnet.orange.count)}"
}

# kubernetes masters
# inbound
resource "aws_network_acl_rule" "master_to_master_api_server" {
  network_acl_id = "${aws_network_acl.orange.id}"
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${element(data.aws_subnet.orange.*.cidr_block, count.index)}"
  from_port      = 6443
  to_port        = 6443

  count = "${length(data.aws_subnet.orange.count)}"
}
