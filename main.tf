provider "aws" {
  region = "eu-west-1"
}

module "kubernetes" {
  source = "./modules/kubernetes"
  rds-security-group = "${module.rds.db_access_sg_id}"
}


module "rds" {
  source = "github.com/shashanksinha89/terraform-ecs-efs-rds/rds"
  environment       = "production"
  allocated_storage = "20"
  database_name     = "${var.production_database_name}"
  database_username = "${var.production_database_username}"
  database_password = "${var.production_database_password}"
  subnet_ids        = "${module.kubernetes.node_subnet_ids}"
  vpc_id            = "${module.kubernetes.vpc_id}"
  instance_class    = "db.t2.micro"
}
