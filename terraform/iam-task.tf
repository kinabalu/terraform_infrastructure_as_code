# Task Role Assume Policy
data "aws_iam_policy_document" "task-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.name}-ecs-task"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.task-assume-role-policy.json}"
}

# Task Role Policy: Custom
resource "aws_iam_policy" "ecs-task-policy" {
  name        = "${var.name}-default-task-policy"
  description = "A default task policy for ECS"
  policy      = <<EOF
{
   "Version":"2012-10-17",
   "Statement" : [
     {
        "Effect":"Allow",
        "Action":["sqs:SendMessage", "sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueUrl", "sqs:GetQueueAttributes"],
        "Resource": "*"
     },
     {
       "Effect": "Allow",
       "Action": [
         "s3:PutObject",
         "s3:GetObject",
         "s3:DeleteObject"
       ],
       "Resource": [
         "arn:aws:s3:::*"
       ]
     }
   ]
}
EOF
}

# Task Policy Attach: Custom
resource "aws_iam_policy_attachment" "ecs-task-policy" {
  name       = "${var.name}-ecs-task-policy"
  roles      = ["${aws_iam_role.ecs_task_role.name}"]
  policy_arn = "${aws_iam_policy.ecs-task-policy.arn}"
}
