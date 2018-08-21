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

resource "aws_instance" "master1" {
    ami                         = "ami-2a7d75c0"
    availability_zone           = "eu-west-1a"
    ebs_optimized               = false
    instance_type               = "t2.medium"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "subnet-62b56138"
    vpc_security_group_ids      = ["sg-cd47c0b1", "sg-a58302d9", "sg-db56c3a7"]
    associate_public_ip_address = false
    private_ip                  = "30.0.24.6"
    source_dest_check           = false

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "master1"
    }
}

resource "aws_instance" "worker1" {
    ami                         = "ami-2a7d75c0"
    availability_zone           = "eu-west-1a"
    ebs_optimized               = false
    instance_type               = "t2.medium"
    monitoring                  = false
    key_name                    = "itv"
    subnet_id                   = "subnet-b58e5aef"
    vpc_security_group_ids      = ["sg-a736b1db", "sg-e98d0c95"]
    associate_public_ip_address = false
    private_ip                  = "20.0.6.201"
    source_dest_check           = false

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "worker1"
        "kpn" = "itv"
    }
}

