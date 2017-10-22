
/* http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI_launch_latest.html */
variable "aws_amis" {
  description = "AMI/Region launch config.  Defaults to ECS Optimized AWS AMI."
  type = "map"
  default = {
    "us-east-1" = "ami-ec33cc96"
    "us-east-2" = "ami-34032e51"
    "us-west-2" = "ami-29f80351"
  }
}

variable "name" {
  description = "App Name"
}

variable "aws_region" {
  description = "The AWS region to run the cluster."
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "namespace_prefix" {
  description = "Namespace Prefix - To distinguish between multiple terraform deploys.  Empty by default"
  default = ""
}

variable "ecs_ondemand_instance_type" {
  description = "AWS instance type"
}

variable "ecs_spot_instance_type" {
  description = "AWS instance type"
  default = "t2.micro"
}

variable "ecs_spot_price" {
  description = "AWS instance type"
  default = "0.05"
}

variable "default_cooldown" {
  description = "AutoScaleGroup - default cooldown in seconds."
  default = "300"
}

variable "asg_servers_desired" {
  description = "Desired number of cluster instances"
  default     = "2"
}

variable "asg_min_size" {
  description = "Minimum number of cluster ondemand instances."
  default = "0"
}

variable "asg_max_size" {
  description = "Maximum number of cluster ondemand instances."
  default = "10"
}

variable "asg_spot_servers_desired" {
  description = "Desired number of cluster spot instances"
  default     = "0"
}

variable "asg_spot_min_size" {
  description = "Minimum number of cluster spot instances."
  default = "0"
}

variable "asg_spot_max_size" {
  description = "Maximum number of cluster spot instances."
  default = "10"
}

variable "api_task_desired" {
  description = "Desired number of api instances"
  default     = "2"
}

// RDS Variables

variable "rds_instance_identifier" {
  description = "RDS Instance Identifier"
}

variable "rds_allocated_storage" {
  description  = "RDS Allocated Storage (in GB)"
}

variable "rds_engine_type" {
  description = "RDS Engine Type"
}

variable "rds_instance_class" {
  description = "RDS Instance Class"
}

variable "rds_engine_version" {
  description = "RDS Engine Version"
}

variable "db_parameter_group" {
  description = "RDS Database Parameter Group"
  default     = "postgres9.5"
}

variable "database_name" {
  description = "RDS Database Name"
  default = "j2d"
}

variable "database_user" {
  description = "RDS Database Username"
  default     = "admin"
}

variable "database_password" {
  description = "RDS Database Password"
}

variable "database_port" {
  description = "RDS Database Port"
  default     = 5432
}

variable "rds_private_cidr" {
  description = "The RDS Priate CIDR Addresses"
}

// VPC variables

variable "vpc_cidr" {
	description = "The IP range for the VPC"
}

variable "subnet_1b_cidr" {
	description = "The IP range for the 1b subnet"
}

variable "subnet_1c_cidr" {
	description = "The IP range for the 1c subnet"
}

variable "show_sql" {
  default = "false"
  description = "Enables logging of Hibernate SQL"
}
