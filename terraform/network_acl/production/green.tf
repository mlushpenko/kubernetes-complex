data "aws_subnet_ids" "green" {
  vpc_id = "${var.vpc_id}"

  tags {
    VPC = "Production"
    Subnet = "Green"
  }
}

data "aws_subnet" "green" {
  count = "${length(data.aws_subnet_ids.green.ids)}"
  id = "${data.aws_subnet_ids.green.ids[count.index]}"
}

resource "aws_network_acl" "green" {
  vpc_id = "${var.vpc_id}"
  subnet_ids = ["${data.aws_subnet_ids.green.ids}"]
}

# Rules
