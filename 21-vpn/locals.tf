locals {
    ami_id = data.aws_ami.openvpn.id
    openvpn_sg_id = data.aws_ssm_parameter.openvpn_sg_id.value
    public_subnet_id = split("," , data.aws_ssm_parameter.public_subnet_ids.value)[0]
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = "true"
    }

    
}