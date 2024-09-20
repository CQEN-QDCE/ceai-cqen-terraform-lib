variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "aws_api_gateway_subnet_ids" {
    type        = list(string)
    description = "La liste des IDs des subnets web du VPC."
    sensitive   = false
}

variable "aws_api_gateway_security_group_ids" {
    type        = list(string)
    description = "Liste d'IDs des groups de sécurité du VPC qui seront associés."
    sensitive   = false
}

variable "aws_api_gateway_integration_alb_listener_arn" {
    type        = string
    description = "L'ARN du listener du load balancer de l'application"
}

variable "use_route53" {
  type    = bool
  default = true
}

variable "aws_api_route53_zone_id" {
  type = string
  description = "ID de la zone hebergé de la Route53."
  default = null
} 

variable "aws_cert_domain_name" {
  type = string
  description = "Nom du domain du certificat."  
}





