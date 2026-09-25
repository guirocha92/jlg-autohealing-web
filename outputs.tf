output "website_public_ip_address" {
  description = "Public IP address visitors can use after deployment."
  value       = module.load_balancer.public_ip_address
}
