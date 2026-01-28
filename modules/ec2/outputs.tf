output "app_security_group_id" {
  description = "The ID of the security group for the application servers"
  value       = aws_security_group.app_sg.id
}

output "alb_dns_name" {
  description = "The public DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}