
output "ec2_1_public_ip" {
  description = "Public IP address of EC2 instance 1"
  value       = aws_instance.ec2-1.public_ip
}

output "ec2_2_public_ip" {
  description = "Public IP address of EC2 instance 2"
  value       = aws_instance.ec2-2.public_ip
}
output "ec2_1_id" {
  description = "Instance ID for EC2 instance 1"
  value       = aws_instance.ec2-1.id
}

output "ec2_2_id" {
  description = "Instance ID for EC2 instance 2"
  value       = aws_instance.ec2-2.id
}