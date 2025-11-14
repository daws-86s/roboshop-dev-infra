resource "aws_cloudfront_distribution" "roboshop" {
  
  origin {
    # roboshop-dev.daws86s.fun
    domain_name = "${var.project_name}-${var.environment}.${var.domain_name}"
    origin_id   = "${var.project_name}-${var.environment}.${var.domain_name}"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  
  # dev.daws86s.fun
  aliases = ["${var.environment}.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id        = local.cachingDisabled
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id        = local.cachingOptimised
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id        = local.cachingOptimised
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "IN", "TH", "DE"]
    }
  }

  tags = merge(
   local.common_tags,
   {
    Name = "${var.project_name}-${var.environment}"
   }
  )

  viewer_certificate {
    acm_certificate_arn = local.cdn_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_route53_record" "cdn" {
  zone_id = var.zone_id
  name    = "${var.environment}.${var.domain_name}" # dev.daws86s.fun
  type    = "A"
  allow_overwrite = true

  alias {
    # These are ALB details, not our domain details
    name                   = aws_cloudfront_distribution.roboshop.domain_name
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = true
  }
}