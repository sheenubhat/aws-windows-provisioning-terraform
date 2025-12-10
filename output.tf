output "instance_ip" {
    value = aws_instance.Windows.public_ip
}

output "private_key_pem" {
    value = tls_private_key.generated_key.private_key_pem
    sensitive = true
}