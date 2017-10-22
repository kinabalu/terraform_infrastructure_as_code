# Create a new load balancer
resource "aws_elb" "default" {

  name               = "${var.name}-default"
  security_groups = ["${aws_security_group.j2d_elb.id}"]
  subnets = ["${aws_subnet.public_1b.id}", "${aws_subnet.public_1c.id}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/health"
    interval            = 30
  }

  cross_zone_load_balancing   = true

  tags {
    Name = "${var.name}-elb"
  }

}
