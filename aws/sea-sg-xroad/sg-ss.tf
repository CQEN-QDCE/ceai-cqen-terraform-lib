############################
# Security Groups (sans ingress inline)
############################

locals {
  ss_suffix = var.is_central_services ? "mss" : "ss"
}

# Groupe de sécurité pour les NLB "inbound" (trafic entrant applicatif)
# utilisé par les load balancers "ss_inbound"
resource "aws_security_group" "nlb_ss_internal_sg" {
  name        = "${local.name}-nlb-${local.ss_suffix}-internal-sg"
  description = "NLB public" # NLB exposé au périmètre (interne ou public selon subnets)
  vpc_id      = var.sea_network.shared_vpc.id
  tags        = merge(local.common_tags, { Name = "${local.name}-nlb-${local.ss_suffix}-internal-sg" })
}

# Groupe de sécurité pour l’ALB d’administration interne
# gère le frontend d’administration exposé en HTTPS
resource "aws_security_group" "alb_ss_internal_admin_sg" {
  name        = "${local.name}-alb-${local.ss_suffix}-internal-admin-sg"
  description = "ALB interne (admin)"
  vpc_id      = var.sea_network.shared_vpc.id
  tags        = merge(local.common_tags, { Name = "${local.name}-alb-${local.ss_suffix}-internal-admin-sg" })
}

# Groupe de sécurité des instances EC2 internes
# reçoit le trafic des NLB/ALB et envoie vers la DB
resource "aws_security_group" "eks_ss_internal_sg" {
  name        = "${local.name}-eks-${local.ss_suffix}-internal-sg"
  description = "EC2 trafic interne"
  vpc_id      = var.sea_network.shared_vpc.id
  tags        = merge(local.common_tags, { Name = "${local.name}-eks-${local.ss_suffix}-internal-sg" })
}

# Ingress rule : autorise les ports publics (HTTP/HTTPS/4001) depuis les CIDR autorisés
resource "aws_vpc_security_group_ingress_rule" "nlb_ss_internal_sg" {
  for_each          = local.port_ss_int_inbound_nlb
  security_group_id = aws_security_group.nlb_ss_internal_sg.id
  ip_protocol       = "tcp"
  from_port         = each.value.port
  to_port           = each.value.port
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow ${each.value.port}/tcp (${each.value.name})"
  tags              = merge(local.common_tags, { Name = each.value.name })
}

# Egress rule : permet au NLB inbound d’envoyer le trafic vers les EC2 internes
resource "aws_vpc_security_group_egress_rule" "nlb_ss_internal_sg" {
  for_each                     = local.port_ss_int_outbound_nlb
  security_group_id            = aws_security_group.nlb_ss_internal_sg.id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.eks_ss_internal_sg.id
  description                  = "Allow ${each.value.port}/tcp (${each.value.name})"
  tags                         = merge(local.common_tags, { Name = each.value.name })
}


############################
# ALB admin — ingress / egress
############################

# Ingress rule : ouvre le port HTTPS (443) vers l’ALB admin depuis Internet
resource "aws_vpc_security_group_ingress_rule" "alb_ss_internal_admin_sg" {
  security_group_id = aws_security_group.alb_ss_internal_admin_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTPS"
  tags              = merge(local.common_tags, { Name = "Admin frontend & Management REST API client" })
}

# Egress rule : permet à l’ALB admin d’atteindre les EC2 internes en HTTPS
resource "aws_vpc_security_group_egress_rule" "alb_ss_internal_admin_sg" {
  for_each                     = local.port_admin_alb
  security_group_id            = aws_security_group.alb_ss_internal_admin_sg.id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.eks_ss_internal_sg.id
  description                  = "Allow HTTPS 4000/tcp"
  tags                         = merge(local.common_tags, { Name = each.value.name })
}

############################
# EC2 — ingress depuis NLB / ALB
############################

# Autorise le trafic venant des NLB inbound (HTTP, HTTPS, 4001)
resource "aws_vpc_security_group_ingress_rule" "eks_inbound_ss" {
  for_each                     = local.port_inbound_eks
  security_group_id            = aws_security_group.eks_ss_internal_sg.id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.nlb_ss_internal_sg.id
  description                  = "Allow ${each.value.port}/tcp from internal inbound NLB"
  tags                         = merge(local.common_tags, { Name = each.value.name })
}

# Egress rule : permet à l’ALB admin d’atteindre les EC2 internes en HTTPS
resource "aws_vpc_security_group_egress_rule" "eks_outbound_ss" {
  for_each          = local.port_outbound_eks
  security_group_id = aws_security_group.eks_ss_internal_sg.id
  ip_protocol       = "tcp"
  from_port         = each.value.port
  to_port           = each.value.port
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow ${each.value.port}/tcp from internal inbound NLB"
  tags              = merge(local.common_tags, { Name = each.value.name })
}

# Egress rule : permet à l’ALB admin d’atteindre les EC2 internes en HTTPS
resource "aws_vpc_security_group_egress_rule" "eks_outbound_ss_postgres" {
  for_each                     = local.port_db
  security_group_id            = aws_security_group.eks_ss_internal_sg.id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = var.sea_network.data_security_group.id
  description                  = "Allow ${each.value.port}/tcp from internal inbound NLB"
  tags                         = merge(local.common_tags, { Name = each.value.name })
}

#Egress rule : permet à l’ALB admin d’atteindre les EC2 internes en HTTPS
resource "aws_vpc_security_group_egress_rule" "eks_outbound_cs_management_services" {
  for_each                     = var.is_central_services ? local.port_management_services : {}
  security_group_id            = aws_security_group.eks_ss_internal_sg.id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.nlb_cs_internal_sg[0].id
  description                  = "Allow ${each.value.port}/tcp from internal inbound NLB"
  tags                         = merge(local.common_tags, { Name = each.value.name })
}
