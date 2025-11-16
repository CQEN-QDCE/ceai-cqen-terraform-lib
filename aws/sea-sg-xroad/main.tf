############################
# Locals main
############################
locals {
  # Préfixe de nommage
  name = "${var.system}-${var.environment}"

  # Tags communs
  common_tags = {
    Environment = var.environment
    Project     = var.system
    Component   = "central-serveur"
    ManagedBy   = "terraform"

  }
}

############################
# Ports & définitions par périmètre
############################
locals {
  # Ports écoutés côté EC2 (sert pour SG EC2)
  port_inbound_instance_ec2 = {
    conf_http      = { port = 80, protocol = "TCP", name = "Global configuration distribution HTTP" }
    conf_https     = { port = 443, protocol = "TCP", name = "Global configuration distribution HTTPS" }
    admin_frontend = { port = 4000, protocol = "TCP", name = "Admin frontend & Management REST API client" }
    auth_cert      = { port = 4001, protocol = "TCP", name = "Auth certificate" }
    internal_mgmt  = { port = 4002, protocol = "TCP", name = "Internal management" }
  }

  # NLB public (inbound)
  port_cs_int_in_out_nlb = {
    conf_http  = { port = 80, protocol = "TCP", name = "Global configuration distribution HTTP" }
    conf_https = { port = 443, protocol = "TCP", name = "Global configuration distribution HTTPS" }
    auth_cert  = { port = 4001, protocol = "TCP", name = "Auth certificate" }
  }

  # ALB d’admin (frontend)
  port_admin_alb = {
    admin_frontend = { port = 4000, protocol = "HTTPS", name = "Admin frontend & Management REST API client" }
  }

  # NLB interne (mgmt)
  port_internal_mgmt_nlb = {
    internal_mgmt = { port = 4002, protocol = "TCP", name = "Internal management" }
  }

  # Accès DB
  port_db = {
    db = { port = 5432, protocol = "TCP", name = "Database" }
  }
}

locals {
  // mss ports
  # Ports écoutés côté EC2 (sert pour SG EC2)
  port_inbound_eks = {
    conf_http      = { port = 80, protocol = "TCP", name = "Incoming ACME challenge requests from ACME servers" }
    ss_port1       = { port = 5500, protocol = "TCP", name = "Management service requests from XRoad Members Security Servers" }
    ss_port2       = { port = 5577, protocol = "TCP", name = "Management service requests from XRoad Members Security Servers" }
    admin_frontend = { port = 4000, protocol = "TCP", name = "Admin frontend & Management REST API client" }
  }

  port_outbound_eks = {
    ss_port1   = { port = 5500, protocol = "TCP", name = "Message exchange between Security Servers" }
    ss_port2   = { port = 5577, protocol = "TCP", name = "Querying of OCSP responses between Security Servers" }
    conf_https = { port = 4001, protocol = "TCP", name = "Communication with the Central Server" }
    conf_http  = { port = 80, protocol = "TCP", name = "Downloading global configuration from the Central Server" }
    conf_https = { port = 443, protocol = "TCP", name = "Downloading global configuration from the Central Server" }
    smtp       = { port = 587, protocol = "TCP", name = "SMTP Email Serveur" }
  }

  port_management_services = {
    management_services = { port = 4002, protocol = "TCP", name = "management services" }
  }

  # NLB public (inbound)
  port_ss_int_inbound_nlb = {
    conf_http = { port = 80, protocol = "TCP", name = "Incoming ACME challenge requests from ACME servers" }
    ss_port1  = { port = 5500, protocol = "TCP", name = "Management service requests from XRoad Members Security Servers" }
    ss_port2  = { port = 5577, protocol = "TCP", name = "Management service requests from XRoad Members Security Servers" }
  }

  port_ss_int_outbound_nlb = {
    conf_http = { port = 80, protocol = "TCP", name = "Incoming ACME challenge requests from ACME servers" }
    ss_port1  = { port = 5500, protocol = "TCP", name = "Management service requests from XRoad Members Security Servers" }
    ss_port2  = { port = 5577, protocol = "TCP", name = "Management service requests from XRoad Members Security Servers" }
  }
}