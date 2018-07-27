output "subnet_id" {
  value = "${aws_subnet.main.id}"
}

output "cidr_block" {
  value = "${aws_subnet.main.cidr_block}"
}

output "route_table_id" {
  value = "${aws_route_table.main.id}"
}
