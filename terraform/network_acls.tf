# module "blue_network_acl" {
#   source = "./network_acl/blue"
#   vpc_id = "${module.blue_vpc.vpc_id}"
#   tags   = "${merge(var.tags, map("VPC", "Blue"))}"
# }
#
# module "production_network_acl" {
#   source = "./network_acl/production"
#   vpc_id = "${module.production_vpc.vpc_id}"
#   tags   = "${merge(var.tags, map("VPC", "Production"))}"
# }
