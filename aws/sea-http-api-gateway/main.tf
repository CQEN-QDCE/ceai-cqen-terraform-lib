locals {
  name = "${var.identifier}"
}

data "aws_caller_identity" "current" {}


###################
# HTTP API Gateway
###################

resource "aws_apigatewayv2_api" "api_http_gateway" {
  name = "${local.name}-http-gateway"
  description = "${local.name} HTTP API Gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "staging" {
    api_id = aws_apigatewayv2_api.api_http_gateway.id

    name = "$default"
    auto_deploy = true  
}

# VPC link
resource "aws_apigatewayv2_vpc_link" "api_vpc_link" {
  name               = "${local.name}-vpc-link"
  security_group_ids = var.aws_api_gateway_security_group_ids
  subnet_ids         = var.aws_api_gateway_subnet_ids
}

#integration
resource "aws_apigatewayv2_integration" "api_integration" {
  api_id = aws_apigatewayv2_api.api_http_gateway.id

  integration_uri = var.aws_api_gateway_integration_alb_listener_arn
  integration_type = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type = "VPC_LINK"
  connection_id = aws_apigatewayv2_vpc_link.api_vpc_link.id
}

resource "aws_apigatewayv2_route" "api_route" {
    api_id = aws_apigatewayv2_api.api_http_gateway.id

    route_key = "ANY /{proxy+}"
    target = "integrations/${aws_apigatewayv2_integration.api_integration.id}"  
}

###################
# Custom Domain
###################

resource "aws_acm_certificate" "api_domain_cert" {
  domain_name       = var.aws_cert_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }      
}

resource "aws_route53_record" "api_cert_route53_record" {
  count  = var.use_route53 ? 1 : 0

  for_each = {
    for dvo in aws_acm_certificate.api_domain_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.aws_api_route53_zone_id

  depends_on = [
    aws_acm_certificate.api_domain_cert
  ]  
}

resource "aws_acm_certificate_validation" "api_acm_cert_validation" {
  count  = var.use_route53 ? 1 : 0
  certificate_arn         = aws_acm_certificate.api_domain_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.api_cert_route53_record : record.fqdn]
  
}

resource "aws_api_gateway_domain_name" "api_domain" {
 domain_name              = aws_acm_certificate.api_domain_cert.domain_name
 regional_certificate_arn = aws_acm_certificate.api_domain_cert.arn
 security_policy          = "TLS_1_2"
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  depends_on = [ aws_acm_certificate_validation.api_acm_cert_validation ]
}

resource "aws_route53_record" "api_domain_route53_record" {
  count  = var.use_route53 ? 1 : 0

  name    = aws_api_gateway_domain_name.api_domain.domain_name
  type    = "A"
  zone_id = var.aws_api_route53_zone_id
  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.api_domain.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_domain.regional_zone_id
  }
}

resource "aws_apigatewayv2_api_mapping" "api_mapping" {
  api_id      = aws_apigatewayv2_api.api_http_gateway.id
  domain_name = aws_api_gateway_domain_name.api_domain.id
  stage = aws_apigatewayv2_stage.staging.id

  depends_on = [ 
    aws_acm_certificate.api_domain_cert ,
    aws_api_gateway_domain_name.api_domain
  ]
}