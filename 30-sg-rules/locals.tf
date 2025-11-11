locals {
    backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    user_sg_id = data.aws_ssm_parameter.user_sg_id.value
    cart_sg_id = data.aws_ssm_parameter.cart_sg_id.value
    shipping_sg_id = data.aws_ssm_parameter.shipping_sg_id.value
    payment_sg_id = data.aws_ssm_parameter.payment_sg_id.value
    frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
}