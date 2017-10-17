# Instance Role Assume Policy
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Instance Role
resource "aws_iam_role" "ecs_instance" {
  name = "${var.name}-ecs-default"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

# Instance Profile
resource "aws_iam_instance_profile" "ecs" {
  name  = "${var.name}-ecs-default"
  role  = "${aws_iam_role.ecs_instance.name}"
}

# Instance Role Policy: AmazonEC2ContainerServiceforEC2Role
resource "aws_iam_policy_attachment" "ecs_instance" {
  name       = "${var.name}-ecs-default"
  roles      = ["${aws_iam_role.ecs_instance.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Instance Role Policy: Custom
resource "aws_iam_role_policy" "ecs_instance_role_policy" {
    name = "${var.name}-ecs-instance-role-policy"
    policy = "${file("policies/ecs-instance-role-policy.json")}"
    role = "${aws_iam_role.ecs_instance.id}"
}

resource "aws_iam_role" "ecs_service_role" {
    name = "${var.name}-ecs-service-role"
    assume_role_policy = "${file("policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
    name = "${var.name}-ecs-service-role-policy"
    policy = "${file("policies/ecs-service-role-policy.json")}"
    role = "${aws_iam_role.ecs_service_role.id}"
}
