resource "aws_cloudwatch_log_group" "api-log" {

  name = "${var.name}-api"

  tags {
    Environment = "development"
    Application = "${var.name}-api"
  }

}
