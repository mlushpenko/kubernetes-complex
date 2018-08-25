output "stepping_stone_ip" {
  value = "${aws_eip.stepping-stone.public_ip}"
}

output "k8s_lb_dns" {
  value = "${aws_elb.elb-k8s.dns_name}"
}

output "proxy_ip" {
  value = "${aws_instance.proxy.private_ip}"
}