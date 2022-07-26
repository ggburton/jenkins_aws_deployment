output "jenkins-main-node-public-ip" {
  value = aws_instance.jenkins-master.public_ip
}

output "jenkins-worker-public-ips" {
  value = {
    for instance in aws_instance.jenkins-worker-oregon :
    instance.id => instance.public_ip
  }
}

output "lb-DNS-name" {
  value = aws_lb.application_lb.dns_name
}

output "url" {
  value = aws_route53_record.jenkins.fqdn
}
