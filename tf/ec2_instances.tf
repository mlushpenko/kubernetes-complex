resource "aws_instance" "stepping-stone" {
    ami                         = "ami-2a7d75c0"
    availability_zone           = "eu-west-1a"
    ebs_optimized               = false
    instance_type               = "t2.nano"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "subnet-2ebd6974"
    vpc_security_group_ids      = ["sg-cd47c0b1"]
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
    availability_zone           = "eu-west-1a"
    ebs_optimized               = false
    instance_type               = "t2.small"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "subnet-62b56138"
    vpc_security_group_ids      = ["sg-cd47c0b1","sg-db56c3a7"]
    associate_public_ip_address = false
    source_dest_check           = true

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
    availability_zone           = "eu-west-1a"
    ebs_optimized               = false
    instance_type               = "t2.medium"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "subnet-62b56138"
    vpc_security_group_ids      = ["sg-cd47c0b1", "sg-a58302d9"]
    associate_public_ip_address = false
    # private_ip                  = "30.0.24.6"
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

resource "aws_network_interface" "prod" {
    subnet_id         = "${aws_subnet.subnet-orange-prod.id}"
    security_groups   = ["sg-a736b1db", "sg-e98d0c95"]
    source_dest_check = false
    count = "${var.workers_count}"
    tags {
        "Name" = "worker${count.index}-prod"
        "kpn"  = "itv"
    }
}

resource "aws_network_interface" "blue" {
    subnet_id         = "${aws_subnet.subnet-b58e5aef-orange-blue.id}"
    security_groups   = ["sg-a736b1db", "sg-e98d0c95"]
    source_dest_check = false
    count = "${var.workers_count}"
    tags {
        "Name" = "worker${count.index}-blue"
        "kpn"  = "itv"
    }
}

resource "aws_instance" "worker" {
    ami                         = "ami-7c491f05"
    availability_zone           = "eu-west-1a"
    ebs_optimized               = false
    instance_type               = "t2.medium"
    monitoring                  = false
    key_name                    = "itv"
    # subnet_id                   = "subnet-b58e5aef"
    # vpc_security_group_ids      = ["sg-a736b1db", "sg-e98d0c95"]
    # associate_public_ip_address = false
    # private_ip                  = "20.0.6.201"
    # source_dest_check           = false

    count = "${var.workers_count}"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = "${element(aws_network_interface.blue.*.id, count.index)}"
        device_index = 0
        # delete_on_termination = true
    }

    network_interface {
        network_interface_id = "${element(aws_network_interface.prod.*.id, count.index)}"
        device_index = 1
        # delete_on_termination = true
    }

    tags {
        "Name" = "worker${count.index}"
        "kpn" = "itv"
    }
}