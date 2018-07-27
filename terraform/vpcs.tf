module "blue_vpc" {
  source          = "./vpc"
  name            = "Blue"
  cluster_name    = "${var.cluster_name}"
  base_cidr_block = "${var.base_cidr_block}"
  tags            = "${merge(var.tags, map("VPC", "Blue"))}"
}

module "production_vpc" {
  source          = "./vpc"
  name            = "Production"
  cluster_name    = "${var.cluster_name}"
  base_cidr_block = "${var.base_cidr_block}"
  tags            = "${merge(var.tags, map("VPC", "Production"))}"
}
