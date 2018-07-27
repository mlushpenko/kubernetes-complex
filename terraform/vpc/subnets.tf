data "aws_availability_zones" "all" {}

module "red_subnet" {
  source            = "../subnet"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.all.names[0]}"
  tags              = "${merge(var.tags, map("Subnet", "Red"))}"
}

module "orange_subnet" {
  source            = "../subnet"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.all.names[1]}"
  tags              = "${merge(var.tags, map("Subnet", "Orange"))}"
}

module "green_subnet" {
  source            = "../subnet"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.all.names[2]}"
  tags              = "${merge(var.tags, map("Subnet", "Green"))}"
}
