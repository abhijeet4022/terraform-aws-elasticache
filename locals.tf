locals {
  tags        = merge(var.tags, { module-name = "elasticache" }, { env = var.env })
  name_prefix = "${var.env}-${var.elasticache_type}-elasticache"
}