# Global Vars
cluster_name = "devtest"
base_cidr_block = "10.0.0.0/12"
region = "eu-west-1"

# Bastion Host
bastion_size = "t2.medium"

# Kube master
kube_master_num = 3
kube_master_size = "t2.medium"
# etcd cluster
etcd_num = 3
etcd_size = "t2.medium"
# Kube worker
kube_worker_num = 4
kube_worker_size = "t2.medium"

# Settings AWS ELB
elb_api_port = 6443
k8s_secure_api_port = 6443
kube_insecure_apiserver_address = "0.0.0.0"

tags = {
 Env = "devtest"
 Product = "kubernetes"
 Cluster = "devtest"
}
