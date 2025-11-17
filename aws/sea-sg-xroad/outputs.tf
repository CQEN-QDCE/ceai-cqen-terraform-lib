output "nlb_ss_internal_sg_id" {
  description = "SS NLB SG"
  value       = aws_security_group.nlb_ss_internal_sg.id
}

output "alb_ss_internal_admin_sg_id" {
  description = "SS ALB Admin SG"
  value       = aws_security_group.alb_ss_internal_admin_sg.id
}

output "eks_ss_internal_sg_id" {
  description = "SS EKS internal SG"
  value       = aws_security_group.eks_ss_internal_sg.id
}

output "nlb_cs_internal_sg_id" {
  description = "CS NLB SG"
  value       = var.is_central_services ? aws_security_group.nlb_cs_internal_sg[0].id : null
}

output "alb_cs_internal_admin_sg_id" {
  description = "CS ALB Admin SG"
  value       = var.is_central_services ? aws_security_group.alb_cs_internal_admin_sg[0].id : null
}

output "nlb_internal_mgmt_sg_id" {
  description = "mgmt NLB SG"
  value       = var.is_central_services ? aws_security_group.nlb_internal_mgmt_sg[0].id : null
}

output "ec2_cs_internal_sg_id" {
  description = "CS EKS internal SG"
  value       = var.is_central_services ? aws_security_group.ec2_cs_internal_sg[0].id : null
}