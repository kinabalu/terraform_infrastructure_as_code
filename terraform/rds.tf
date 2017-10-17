
module "j2d_rds_instance" {
  source = "github.com/terraform-community-modules/tf_aws_rds.git?ref=v1.0.1"

  # RDS Instance Inputs
  rds_instance_identifier = "${var.rds_instance_identifier}"
  rds_allocated_storage = "${var.rds_allocated_storage}"
  rds_engine_type = "${var.rds_engine_type}"
  rds_instance_class = "${var.rds_instance_class}"
  rds_engine_version = "${var.rds_engine_version}"
  db_parameter_group = "${var.db_parameter_group}"

  database_name = "${var.database_name}"
  database_user = "${var.database_user}"
  database_password = "${var.database_password}"
  database_port = "${var.database_port}"

  # DB Subnet Group Inputs
  subnets = ["${aws_subnet.public_1b.id}", "${aws_subnet.public_1c.id}"] # see above
  rds_vpc_id = "${aws_vpc.api.id}"
  private_cidr = ["${var.rds_private_cidr}"]

}
