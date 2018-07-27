resource "aws_vpc" "main" {
  cidr_block = "${cidrsubnet(var.base_cidr_block, 4, lookup(var.vpc_numbers, var.name))}"

  #DNS Related Entries
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = "${merge(
    var.tags,
    map(
      "Name", "${var.cluster_name}"
    )
  )}"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(
    var.tags,
    map(
      "Name", "${var.cluster_name}-internet-gw"
    )
  )}"
}

resource "aws_eip" "nat" {
  vpc = true

  depends_on = ["aws_internet_gateway.main"]

  tags = "${merge(
    var.tags,
    map(
      "Name", "${var.cluster_name}-nat-eip"
    )
  )}"
}

resource "aws_nat_gateway" "main" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${module.red_subnet.subnet_id}"

  depends_on = ["aws_internet_gateway.main"]

  tags = "${merge(
    var.tags,
    map(
      "Name", "${var.cluster_name}-nat-gw"
    )
  )}"
}
