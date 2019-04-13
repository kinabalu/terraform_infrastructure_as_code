resource "aws_elasticache_cluster" "api_cache" {
  cluster_id           = "${var.namespace_prefix}api-cache"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  port                 = 6379
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  subnet_group_name    = "${aws_elasticache_subnet_group.api_cache.name}"
  security_group_ids   = ["${aws_security_group.j2d_elasticache_redis.id}"]

}

resource "aws_elasticache_subnet_group" "api_cache" {
  name       = "${var.name}-cache-subnet"
  subnet_ids = ["${aws_subnet.public_1b.id}", "${aws_subnet.public_1c.id}"]
}
