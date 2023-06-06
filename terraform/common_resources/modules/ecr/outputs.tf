output "repository_url" {
  description = "URL of first repository created"
  value       = aws_ecr_repository.main.repository_url
}
