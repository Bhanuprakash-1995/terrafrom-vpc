module "mongodb" {
  source       = "../../terraform-aws-security-groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
  sg_name        = "mongodb"
  sg_description = "SG for Mongodb"
}
