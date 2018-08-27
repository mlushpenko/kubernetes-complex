resource "aws_eip" "stepping-stone" {
    vpc      = true
    instance = "${aws_instance.stepping-stone.id}"
    tags {
        "kpn" = "itv"
    }

    depends_on = ["aws_internet_gateway.internet"]
}

resource "aws_instance" "stepping-stone" {
    ami                         = "ami-2a7d75c0"
    ebs_optimized               = false
    instance_type               = "t2.nano"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "${aws_subnet.blue-red.id}"
    vpc_security_group_ids      = ["${aws_security_group.basic-blue.id}"]
    associate_public_ip_address = true
    private_ip                  = "30.0.10.41"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "stepping-stone"
        "kpn" = "itv"
    }
}

resource "aws_instance" "proxy" {
    ami                         = "ami-2a7d75c0"
    ebs_optimized               = false
    instance_type               = "t2.small"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "${aws_subnet.blue-orange.id}"
    vpc_security_group_ids      = ["${aws_security_group.basic-blue.id}","${aws_security_group.proxy.id}"]
    associate_public_ip_address = false
    source_dest_check           = true
    disable_api_termination     = false
    user_data                   = "${file("ec2_user_data/proxy.sh")}"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "proxy"
        "kpn" = "itv"
    }
}

resource "aws_instance" "master" {
    ami                         = "ami-7c491f05"
    ebs_optimized               = false
    instance_type               = "t2.medium"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "${aws_subnet.blue-orange.id}"
    vpc_security_group_ids      = ["${aws_security_group.basic-blue.id}", "${aws_security_group.kube-master.id}"]
    associate_public_ip_address = false
    source_dest_check           = false

    count = "${var.masters_count}"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

    tags {
        "Name" = "master${count.index}"
        "kpn"  = "itv"
    }
}

data "template_file" "user_data_kube_worker" {
  template = "${file("ec2_user_data/worker.sh")}"

  vars {
    proxy_ip   = "${aws_instance.proxy.private_ip}"
  }
}

resource "aws_network_interface" "blue" {
    subnet_id         = "${aws_subnet.orange-blue.id}"
    security_groups   = ["${aws_security_group.basic-prod.id}", "${aws_security_group.kube-node.id}"]
    source_dest_check = false
    count = "${var.workers_count}"
    tags {
        "Name" = "worker${count.index}-blue"
        "kpn"  = "itv"
        "prod-zone" = "orange"
    }
}

resource "aws_network_interface" "prod" {
    subnet_id         = "${aws_subnet.orange-prod.id}"
    security_groups   = ["${aws_security_group.basic-prod.id}"]
    source_dest_check = false
    count = "${var.workers_count}"
    tags {
        "Name" = "worker${count.index}-prod"
        "kpn"  = "itv"
        "prod-zone" = "orange"
    }
}

resource "aws_instance" "worker" {
    ami                         = "ami-7c491f05"
    ebs_optimized               = false
    instance_type               = "t2.medium"
    monitoring                  = false
    key_name                    = "itv"
    user_data                   = "${data.template_file.user_data_kube_worker.rendered}"

    count = "${var.workers_count}"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = "${element(aws_network_interface.blue.*.id, count.index)}"
        device_index = 0
    }

    network_interface {
        network_interface_id = "${element(aws_network_interface.prod.*.id, count.index)}"
        device_index = 1
    }

    tags {
        "Name" = "worker${count.index}"
        "kpn" = "itv"
        "prod-zone" = "orange"
    }
}

resource "aws_network_interface" "red-blue" {
    subnet_id         = "${aws_subnet.red-blue.id}"
    security_groups   = ["${aws_security_group.basic-prod.id}", "${aws_security_group.kube-node.id}"]
    source_dest_check = false
    count = "1"
    tags {
        "Name" = "worker${count.index}-red-blue"
        "kpn"  = "itv"
        "prod-zone" = "red"
    }
}

resource "aws_network_interface" "red-prod" {
    subnet_id         = "${aws_subnet.red-prod.id}"
    security_groups   = ["${aws_security_group.basic-prod.id}"]
    source_dest_check = false
    count = "1"
    tags {
        "Name" = "worker${count.index}-red-prod"
        "kpn"  = "itv"
        "prod-zone" = "red"
    }
}

resource "aws_instance" "worker-red" {
    ami                         = "ami-7c491f05"
    ebs_optimized               = false
    instance_type               = "t2.medium"
    monitoring                  = false
    key_name                    = "itv"
    user_data                   = "${data.template_file.user_data_kube_worker.rendered}"

    count = "1"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = "${aws_network_interface.red-blue.id}"
        device_index = 0
    }

    network_interface {
        network_interface_id = "${aws_network_interface.red-prod.id}"
        device_index = 1
    }

    tags {
        "Name" = "worker${count.index}-red"
        "kpn" = "itv"
        "prod-zone" = "red"
    }
}