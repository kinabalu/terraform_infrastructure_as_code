# Launch Configuration
resource "aws_launch_configuration" "lc-spot" {
  name          = "${var.name}-lc-spot"
  image_id      = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.ecs_spot_instance_type}"
  spot_price    = "${var.ecs_spot_price}"
  associate_public_ip_address = true
  iam_instance_profile   = "${aws_iam_instance_profile.ecs.name}"

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<USER_DATA
#!/bin/bash
# Set the cluster
echo ECS_CLUSTER=${aws_ecs_cluster.default.name} >> /etc/ecs/ecs.config
USER_DATA

  # Security group
  security_groups = ["${aws_security_group.default.id}"]
  key_name        = "${var.key_name}"
}

# AutoScaleGroup
resource "aws_autoscaling_group" "asg-spot" {

  availability_zones      = ["${aws_subnet.public_1b.availability_zone}", "${aws_subnet.public_1c.availability_zone}"]
  name                    = "${var.name}-asg-spot"
  max_size                = "${var.asg_spot_max_size}"
  min_size                = "${var.asg_spot_min_size}"
  desired_capacity        = "${var.asg_spot_servers_desired}"
  default_cooldown        = "${var.default_cooldown}"

  force_delete            = true
  launch_configuration    = "${aws_launch_configuration.lc-spot.name}"
  load_balancers = ["${aws_elb.default.name}"]

  lifecycle {
      create_before_destroy = true
  }

  depends_on = ["aws_launch_configuration.lc"]
  vpc_zone_identifier = ["${aws_subnet.public_1b.id}", "${aws_subnet.public_1c.id}"]

  tag {
    key                 = "Name"
    value               = "${var.name}-worker-spot"
    propagate_at_launch = "true"
  }

}
