output "name" {
  value = "${var.name}"
}

output "region" {
  value = "${var.aws_region}"
}

output "cluster_name" {
  value = "${aws_ecs_cluster.default.name}"
}

output "rds_security_group" {
  value = "${aws_security_group.j2d_postgresql_rds.id}"
}

output "elasticache_security_group" {
  value = "${aws_security_group.j2d_elasticache_redis.id}"
}

output "elb_security_group" {
  value = "${aws_security_group.j2d_elb.id}"
}

output "elb_dns_name" {
  value = "${aws_elb.default.dns_name}"
}

output "launch_configuration" {
  value = "${aws_launch_configuration.lc.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.asg.id}"
}

output "j2d_vpc" {
  value = "${aws_vpc.api.id}"
}

output "api_repo_url" {
  value = "${aws_ecr_repository.api.repository_url}"
}

output "j2d_cluster_arn" {
  value = "${aws_ecs_cluster.default.id}"
}

output "api_service_name" {
  value = "${aws_ecs_service.api.name}"
}

output "api_task_arn" {
  value = "${aws_ecs_task_definition.api.arn}"
}
