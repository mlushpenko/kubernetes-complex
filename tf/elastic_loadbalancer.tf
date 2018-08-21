resource "aws_elb" "elb-k8s" {
    name                        = "elb-k8s"
    subnets                     = ["subnet-62b56138"]
    security_groups             = ["sg-018134aa840a6c9e1"]
    instances                   = ["i-002f93638cadcc2ae"]
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

