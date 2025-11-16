############################
# Security Groups (sans ingress inline)
############################

# Groupe de sécurité pour les NLB "inbound" (trafic entrant applicatif)
# utilisé par les load balancers "cs_inbound"
resource "aws_security_group" "nlb_cs_internal_sg" {
  count       = var.is_central_services ? 1 : 0
  name        = "${local.name}-nlb-cs-internal-sg"
  description = "NLB public" # NLB exposé au périmètre (interne ou public selon subnets)
  vpc_id      = var.sea_network.shared_vpc.id
  tags        = merge(local.common_tags, { Name = "${local.name}-nlb-cs-internal-sg" })
}

# Groupe de sécurité pour l’ALB d’administration interne
# gère le frontend d’administration exposé en HTTPS
resource "aws_security_group" "alb_cs_internal_admin_sg" {
  count       = var.is_central_services ? 1 : 0
  name        = "${local.name}-alb-cs-internal-admin-sg"
  description = "ALB interne (admin)"
  vpc_id      = var.sea_network.shared_vpc.id
  tags        = merge(local.common_tags, { Name = "${local.name}-alb-cs-internal-admin-sg" })
}

# Groupe de sécurité pour le NLB "management"
# autorise le trafic interne d’administration vers les EC2
resource "aws_security_group" "nlb_internal_mgmt_sg" {
  count       = var.is_central_services ? 1 : 0
  name        = "${local.name}-nlb-internal-mgmt-sg"
  description = "NLB interne (mgmt)"
  vpc_id      = var.sea_network.shared_vpc.id
  tags        = merge(local.common_tags, { Name = "${local.name}-nlb-internal-mgmt-sg" })
}

# Groupe de sécurité des instances EC2 internes
# reçoit le trafic des NLB/ALB et envoie vers la DB
resource "aws_security_group" "ec2_cs_internal_sg" {
  count       = var.is_central_services ? 1 : 0
  name        = "${local.name}-ec2-cs-internal-sg"
  description = "EC2 trafic interne"
  vpc_id      = var.sea_network.shared_vpc.id
  tags        = merge(local.common_tags, { Name = "${local.name}-ec2-cs-internal-sg" })
}

# Ingress rule : autorise les ports publics (HTTP/HTTPS/4001) depuis les CIDR autorisés
resource "aws_vpc_security_group_ingress_rule" "nlb_cs_internal_sg" {
  for_each          = var.is_central_services ? local.port_cs_int_in_out_nlb : {}
  security_group_id = aws_security_group.nlb_cs_internal_sg[0].id
  ip_protocol       = "tcp"
  from_port         = each.value.port
  to_port           = each.value.port
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow ${each.value.port}/tcp (${each.value.name})"
  tags              = merge(local.common_tags, { Name = each.value.name })
  depends_on        = [aws_security_group.alb_cs_internal_admin_sg]
}

# Egress rule : permet au NLB inbound d’envoyer le trafic vers les EC2 internes
resource "aws_vpc_security_group_egress_rule" "nlb_cs_internal_sg" {
  for_each                     = var.is_central_services ? local.port_cs_int_in_out_nlb : {}
  security_group_id            = aws_security_group.nlb_cs_internal_sg[0].id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.ec2_cs_internal_sg[0].id
  description                  = "Allow ${each.value.port}/tcp (${each.value.name})"
  tags                         = merge(local.common_tags, { Name = each.value.name })
  depends_on                   = [aws_security_group.ec2_cs_internal_sg, aws_security_group.nlb_cs_internal_sg]
}


############################
# ALB admin — ingress / egress
############################

# Ingress rule : ouvre le port HTTPS (443) vers l’ALB admin depuis Internet
resource "aws_vpc_security_group_ingress_rule" "alb_cs_internal_admin_sg" {
  count             = var.is_central_services ? 1 : 0
  security_group_id = aws_security_group.alb_cs_internal_admin_sg[0].id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTPS"
  tags              = merge(local.common_tags, { Name = "HTTPS" })
  depends_on        = [aws_security_group.alb_cs_internal_admin_sg]
}

# # Egress rule : permet à l’ALB admin d’atteindre les EC2 internes en HTTPS
resource "aws_vpc_security_group_egress_rule" "alb_cs_internal_admin_sg" {
  for_each                     = var.is_central_services ? local.port_admin_alb : {}
  security_group_id            = aws_security_group.alb_cs_internal_admin_sg[0].id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.ec2_cs_internal_sg[0].id
  description                  = "Allow HTTPS"
  tags                         = merge(local.common_tags, { Name = "HTTPS" })
  depends_on                   = [aws_security_group.alb_cs_internal_admin_sg, aws_security_group.ec2_cs_internal_sg]
}

############################
# Ingress NOMMÉES — NLB mgmt (CIDR)
############################

# Ingress rule : autorise le trafic management depuis les CIDR internes
resource "aws_vpc_security_group_ingress_rule" "nlb_internal_mgmt" {
  for_each                     = var.is_central_services ? local.port_internal_mgmt_nlb : {}
  security_group_id            = aws_security_group.nlb_internal_mgmt_sg[0].id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.eks_ss_internal_sg.id
  description                  = "Allow ${each.value.port}/tcp (${each.value.name})"
  tags                         = merge(local.common_tags, { Name = each.value.name })
  depends_on                   = [aws_security_group.eks_ss_internal_sg, aws_security_group.nlb_internal_mgmt_sg]
}

# Egress rule : permet au NLB mgmt d’envoyer le trafic vers les EC2 internes
resource "aws_vpc_security_group_egress_rule" "nlb_internal_mgmt" {
  for_each                     = var.is_central_services ? local.port_internal_mgmt_nlb : {}
  security_group_id            = aws_security_group.nlb_internal_mgmt_sg[0].id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.ec2_cs_internal_sg[0].id
  description                  = "Allow ${each.value.port}/tcp (${each.value.name})"
  tags                         = merge(local.common_tags, { Name = each.value.name })
  depends_on                   = [aws_security_group.ec2_cs_internal_sg, aws_security_group.nlb_internal_mgmt_sg]
}

############################
# EC2 — ingress depuis NLB / ALB
############################

# Autorise le trafic venant des NLB inbound (HTTP, HTTPS, 4001)
resource "aws_vpc_security_group_ingress_rule" "ec2_from_internal_cs_nlb" {
  for_each                     = var.is_central_services ? local.port_cs_int_in_out_nlb : {}
  security_group_id            = aws_security_group.ec2_cs_internal_sg[0].id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.nlb_cs_internal_sg[0].id
  description                  = "Allow ${each.value.port}/tcp from internal inbound NLB"
  tags                         = merge(local.common_tags, { Name = each.value.name })
  depends_on                   = [aws_security_group.nlb_cs_internal_sg]
}

# Autorise le trafic depuis le NLB management interne
resource "aws_vpc_security_group_ingress_rule" "ec2_from_internal_mgmt_nlb" {
  for_each                     = var.is_central_services ? local.port_internal_mgmt_nlb : {}
  security_group_id            = aws_security_group.ec2_cs_internal_sg[0].id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.nlb_internal_mgmt_sg[0].id
  description                  = "Allow ${each.value.port}/tcp from internal mgmt NLB"
  tags                         = merge(local.common_tags, { Name = each.value.name })
  depends_on                   = [aws_security_group.nlb_internal_mgmt_sg]
}

# Autorise le trafic HTTPS depuis l’ALB admin interne vers les EC2
resource "aws_vpc_security_group_ingress_rule" "ec2_from_internal_admin_cs_alb" {
  for_each                     = var.is_central_services ? local.port_admin_alb : {}
  security_group_id            = aws_security_group.ec2_cs_internal_sg[0].id
  ip_protocol                  = "tcp"
  from_port                    = each.value.port
  to_port                      = each.value.port
  referenced_security_group_id = aws_security_group.alb_cs_internal_admin_sg[0].id
  description                  = "Allow ${each.value.port}/tcp from admin ALB"
  tags                         = merge(local.common_tags, { Name = each.value.name })
  depends_on                   = [aws_security_group.alb_cs_internal_admin_sg]
}

############################
# EC2 — egress vers Postgres
############################

# Permet aux EC2 internes d’atteindre la base de données (Postgres)
resource "aws_vpc_security_group_egress_rule" "ec2_to_postgres" {
  for_each          = var.is_central_services ? local.port_db : {}
  security_group_id = aws_security_group.ec2_cs_internal_sg[0].id
  ip_protocol       = "tcp"
  from_port         = each.value.port
  to_port           = each.value.port
  # cidr_ipv4                  = "10.20.30.0/24"  # optionnel : restriction directe
  referenced_security_group_id = var.sea_network.data_security_group.id
  description                  = "Allow ${each.value.port}/tcp to Postgres"
  tags                         = merge(local.common_tags, { Name = each.value.name })
  depends_on                   = [aws_security_group.ec2_cs_internal_sg]
}
