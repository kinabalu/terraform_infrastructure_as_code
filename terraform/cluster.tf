# ECS Service cluster
resource "aws_ecs_cluster" "default" {
  name = "${var.name}"
}
