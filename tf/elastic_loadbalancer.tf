resource "aws_elb" "elb-k8s" {
    name                        = "elb-k8s"
    subnets                     = ["${aws_subnet.subnet-62b56138-orange.id}"]
    security_groups             = ["${aws_security_group.elb-k8s.id}","${aws_security_group.basic-blue.id}"]
    instances                   = ["${aws_instance.master.*.id}"]
    cross_zone_load_balancing   = false
    idle_timeout                = 60
    connection_draining         = true
    connection_draining_timeout = 300
    internal                    = true

    listener {
        instance_port      = 6443
        instance_protocol  = "tcp"
        lb_port            = 443
        lb_protocol        = "tcp"
        ssl_certificate_id = ""
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        interval            = 5
        target              = "TCP:6443"
        timeout             = 2
    }

    tags {
        "kpn" = "itv"
    }
}

