resource "aws_vpc" "api" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_1b" {
  vpc_id = "${aws_vpc.api.id}"
  cidr_block = "${var.subnet_1b_cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.name} Public 1B"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = "${aws_vpc.api.id}"
  cidr_block = "${var.subnet_1c_cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.aws_region}c"

  tags {
    Name = "${var.name} Public 1C"
  }

}

# VPC Route Table
resource "aws_route_table" "external" {
  vpc_id = "${aws_vpc.api.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

# Primary Subnet
resource "aws_route_table_association" "primary" {
  subnet_id = "${aws_subnet.public_1b.id}"
  route_table_id = "${aws_route_table.external.id}"
}

# Secondary Subnet
resource "aws_route_table_association" "secondary" {
  subnet_id = "${aws_subnet.public_1c.id}"
  route_table_id = "${aws_route_table.external.id}"
}


resource "aws_security_group" "j2d_postgresql_rds" {
  name = "${var.name}-rds"
  description = "Allow access to PostgreSQL RDS"
  vpc_id = "${aws_vpc.api.id}"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //    cidr_blocks = ["${aws_ecs_service.task1-service.private_ip}","${aws_instance.web02.private_ip}"]
  }

  egress {
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "j2d_elasticache_redis" {
  name = "${var.name}-elasticache_redis"
  description = "Allows access from API to Redis"
  vpc_id      = "${aws_vpc.api.id}"

  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.api.id}"
  tags {
    Name = "${var.name}-igw"
  }
}

resource "aws_security_group" "j2d_elb" {
  name = "${var.name}-elb2"
  description = "Allows all traffic"
  vpc_id      = "${aws_vpc.api.id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = ["aws_internet_gateway.igw"]

}
