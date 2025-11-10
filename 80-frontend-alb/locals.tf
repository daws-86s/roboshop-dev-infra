locals {
  common_name_suffix = "${var.project_name}-${var.environment}" # roboshop-dev
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
  public_subnet_ids = split("," , data.aws_ssm_parameter.public_subnet_ids.value)
  frontend_alb_certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value
  common_tags = {
    Project = var.project_name
    Environment = var.environment
    Terraform = "true"
  }
}