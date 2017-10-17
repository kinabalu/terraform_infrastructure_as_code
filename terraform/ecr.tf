
resource "aws_ecr_repository" "api" {
  name = "${var.namespace_prefix}api"
}
