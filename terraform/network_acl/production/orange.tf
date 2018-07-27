data "aws_subnet_ids" "orange" {
  vpc_id = "${var.vpc_id}"

  tags {
    VPC = "Production"
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
