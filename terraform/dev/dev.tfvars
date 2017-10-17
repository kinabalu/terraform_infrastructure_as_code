# VPC and subnet info
vpc_cidr = "10.0.0.0/16"
subnet_1b_cidr = "10.0.1.0/24"
subnet_1c_cidr = "10.0.2.0/24"

# Configuration for the ECS tasks.

name = "j2d"
key_name = "test"

ecs_ondemand_instance_type = "t2.large"

asg_servers_desired = 6
asg_min_size = 0
asg_max_size = 6

api_task_desired = 1

# RDS

rds_instance_identifier = "api-j2d-db"
rds_allocated_storage = 10
rds_engine_type = "postgres"
rds_instance_class = "db.t2.micro"
rds_engine_version = "9.6.2"
db_parameter_group = "postgres9.6"
database_name = "j2d"
database_user = "j2d_admin"
database_port = "5432"
database_password = "Password!"

# DB Subnet Group Inputs
subnets = ["${aws_subnet.example.*.id}"] # see above
rds_vpc_id = "rds_app"
rds_private_cidr = "10.0.0.0/16"

# region
aws_region = "us-east-2"
