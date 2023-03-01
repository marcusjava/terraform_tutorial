output "public_dns" {
  value = aws_instance.dev_instance.public_dns
}

output "public_ip" {
  value = aws_instance.dev_instance.public_ip
}