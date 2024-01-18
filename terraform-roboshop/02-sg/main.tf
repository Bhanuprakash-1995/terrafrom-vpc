module "vpn" {
  source         = "../../terraform-aws-security-groups"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.default_vpc_id.value
  sg_name        = "vpn"
  sg_description = "SG for vpn"
}

module "mongodb" {
  source           = "../../terraform-aws-security-groups"
  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name          = "mongodb"
  sg_description   = "SG for Mongodb"
}

module "catalogue" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "catalogue"
  sg_description = "SG for catalogue"
}

module "user" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "user"
  sg_description = "SG for user"
}

module "redis" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "redis"
  sg_description = "SG for redis"
}

module "mysql" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "mysql"
  sg_description = "SG for mysql"
}

module "rabbitmq" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "rabbitmq"
  sg_description = "SG for rabbitmq"
}

module "cart" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "cart"
  sg_description = "SG for cart"
}

module "shipping" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "shipping"
  sg_description = "SG for shipping"
}

module "payment" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "payment"
  sg_description = "SG for payment"
}

module "web" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "web"
  sg_description = "SG for web"
}

resource "aws_security_group_rule" "vpn_home" {
  security_group_id = module.vpn.sg_id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mongodb_vpn" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id        = module.redis.sg_id
}
