output "shared_vpc" {
  value   = data.aws_vpc.shared_vpc
}

output "web_subnets" {
  value   = data.aws_subnets.web_subnets
}

output "app_subnets" {
  value   = data.aws_subnets.app_subnets
}

output "data_subnets" {
  value   = data.aws_subnets.data_subnets
}

output "web_security_group" {
  value   = data.aws_security_group.web_security_group
}

output "app_security_group" {
  value   = data.aws_security_group.app_security_group
}

output "data_security_group" {
  value   = data.aws_security_group.data_security_group
}

output "all" {
    value = {
        shared_vpc = data.aws_vpc.shared_vpc
        web_subnets = data.aws_subnets.web_subnets
        app_subnets = data.aws_subnets.app_subnets
        data_subnets = data.aws_subnets.data_subnets
        web_security_group = data.aws_security_group.web_security_group
        app_security_group = data.aws_security_group.app_security_group
        data_security_group = data.aws_security_group.data_security_group
    }
}
