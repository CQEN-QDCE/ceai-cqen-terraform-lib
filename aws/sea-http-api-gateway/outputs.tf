output "api_id" {
  value       = aws_apigatewayv2_api.api_http_gateway.id
  description = "L'ID de l'API Gateway"
}

output "api_endpoint" {
  value       = aws_apigatewayv2_api.api_http_gateway.api_endpoint
  description = "L'URL d'accès de l'API Gateway"
}

output "vpc_link_id" {
  value       = aws_apigatewayv2_vpc_link.api_vpc_link.id
  description = "L'ID du VPC Link"
}

output "stage_id" {
  value       = aws_apigatewayv2_stage.staging.id
  description = "L'ID du stage de l'API Gateway"
}