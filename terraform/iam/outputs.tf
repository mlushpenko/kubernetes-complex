output "kube_master_profile" {
    value = "${aws_iam_instance_profile.kube_master.name }"
}

output "kube_worker_profile" {
    value = "${aws_iam_instance_profile.kube_worker.name }"
}
