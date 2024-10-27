# Elasticache subnet Group.
resource "aws_elasticache_subnet_group" "main" {
  name       = "${local.name_prefix}-subnet-group"
  subnet_ids = var.db_subnets
  tags       = merge(var.tags, { Name = "${local.name_prefix}-subnet-group" })
}

# Parameter Group
resource "aws_elasticache_parameter_group" "default" {
  name   = "${local.name_prefix}-pg"
  family = var.engine_family
  tags   = merge(local.tags, { Name = "${local.name_prefix}-pg" })
}


# SG for Redis Elasticache.
resource "aws_security_group" "main" {
  name        = "${local.name_prefix}-sg"
  description = "${local.name_prefix}-sg"
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { Name = "${local.name_prefix}-sg" })
}


# Ingress rule for Aurora SQL.
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each          = toset(var.app_subnets_cidr) # Convert list to a set to iterate over each CIDR
  description       = "Allow inbound TCP on ${var.elasticache_type} port ${var.port} from App Subnets"
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value # Each CIDR block as a separate rule
  from_port         = var.port
  to_port           = var.port
  ip_protocol       = "tcp"
  tags              = { Name = "App-to-${var.elasticache_type}-${var.port}-${each.value}" }
}


# Egress rule for Aurora SQL.
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}