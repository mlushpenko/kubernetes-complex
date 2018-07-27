resource "aws_route" "red_internet_gw" {
  route_table_id = "${module.red_subnet.route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id  = "${aws_internet_gateway.main.id}"
}

resource "aws_route" "orange_nat_gw" {
  route_table_id = "${module.orange_subnet.route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.main.id}"
}
