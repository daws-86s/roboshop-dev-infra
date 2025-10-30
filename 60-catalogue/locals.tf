locals {
  common_name_suffix = "${var.project_name}-${var.environment}" # roboshop-dev
  private_subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
  ami_id = data.aws_ami.joindevops.id
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
  common_tags = {
      Project = var.project_name
      Environment = var.environment
      Terraform = "true"
  }
}
