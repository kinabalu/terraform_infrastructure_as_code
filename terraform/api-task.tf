
# Data Queue Task Definition

data "aws_ecs_task_definition" "api" {

  task_definition = "${aws_ecs_task_definition.api.family}"

  depends_on = [
    "aws_ecs_task_definition.api"
  ]

}

data "template_file" "api_container_definitions" {

  template = "${file("container/api.json")}"

  vars {
    name = "${var.name}"
    region = "${var.aws_region}"
    ecs_task_role_arn = "${aws_iam_role.ecs_task_role.arn}"
    rds_instance_address = "${module.j2d_rds_instance.rds_instance_address}"
    task_repo = "${aws_ecr_repository.api.repository_url}"
    database_name = "${var.database_name}"
    database_user = "${var.database_user}"
    database_password = "${var.database_password}"
    cache_node_address = "${aws_elasticache_cluster.api_cache.cache_nodes.0.address}"
    log_group = "${aws_cloudwatch_log_group.api-log.name}"
  }

}

resource "aws_ecs_task_definition" "api" {
  family = "${var.name}-api"
  task_role_arn = "${aws_iam_role.ecs_task_role.arn}"
  container_definitions = "${data.template_file.api_container_definitions.rendered}"
}

# ECS Service
resource "aws_ecs_service" "api" {

    name            = "${var.name}-api"
    cluster         = "${aws_ecs_cluster.default.id}"

    desired_count   = "${var.api_task_desired}"

    iam_role        = "${aws_iam_role.ecs_service_role.arn}"

    depends_on      = [
      "aws_iam_role.ecs_task_role",
      "aws_ecs_task_definition.api",
      "aws_iam_role_policy.ecs_instance_role_policy"
    ]

    # Track the latest ACTIVE revision
    task_definition = "${aws_ecs_task_definition.api.family}:${max("${aws_ecs_task_definition.api.revision}", "${data.aws_ecs_task_definition.api.revision}")}"

    load_balancer {
      elb_name       = "${aws_elb.default.name}"
      container_name = "api"
      container_port = 8080
    }

}
