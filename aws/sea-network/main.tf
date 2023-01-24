data "aws_vpc" "shared_vpc" {
  tags = {
    Name = "${var.workload_account_type}_vpc"
  }
}

data "aws_subnets" "web_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared_vpc.id]
  }

  filter {
    name = "tag:Name"
    values = ["Web_${var.workload_account_type}_aza_net", "Web_${var.workload_account_type}_azb_net", "Web_${var.workload_account_type}_azd_net"]
  }
}

data "aws_subnets" "app_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared_vpc.id]
  }

  filter {
    name = "tag:Name"
    values = ["App_${var.workload_account_type}_aza_net", "App_${var.workload_account_type}_azb_net", "App_${var.workload_account_type}_azd_net"]
  }
}

data "aws_subnets" "data_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared_vpc.id]
  }

  filter {
    name = "tag:Name"
    values = ["Data_${var.workload_account_type}_aza_net", "Data_${var.workload_account_type}_azb_net", "Data_${var.workload_account_type}_azd_net"]
  }
}

data "aws_security_group" "web_security_group" {
  tags = { 
    Name = "Web_sg"
    }
}

data "aws_security_group" "app_security_group" {
  tags = { 
    Name = "App_sg"
    }
}

data "aws_security_group" "data_security_group" {
  tags = { 
    Name = "Data_sg"
    }
}

data "aws_acm_certificate" "default_internal_ssl_certificate" {
  domain = "*.asea.cqen.org"
}

data "external" "config_rule_elb_logging_enabled" {
  program = ["${path.module}/external/elb_log_bucket_name.sh", "${var.aws_profile}"]
}