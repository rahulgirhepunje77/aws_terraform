output "alb_dns" {
  value       = aws_lb.main.dns_name
  description = "Open this in your browser"
}
