output "web_server_public_ip" {
  description = "The Public IP address of the Web Server"
  value       = aws_instance.web.public_ip
}

output "website_url" {
  value = "http://${aws_instance.web.public_ip}"
}