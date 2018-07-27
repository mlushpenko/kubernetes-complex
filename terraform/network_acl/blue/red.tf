data "aws_subnet_ids" "red" {
  vpc_id = "${var.vpc_id}"

  tags {
    VPC = "Blue"
    Subnet = "Red"
  }
}

data "aws_subnet" "red" {
  count = "${length(data.aws_subnet_ids.red.ids)}"
  id = "${data.aws_subnet_ids.red.ids[count.index]}"
}

resource "aws_network_acl" "red" {
  vpc_id = "${var.vpc_id}"
  subnet_ids = ["${data.aws_subnet_ids.red.ids}"]
}

# Rules
