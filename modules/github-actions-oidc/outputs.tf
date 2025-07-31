output "role_arn" {
  description = "ARN del rol IAM creado para GitHub Actions"
  value       = aws_iam_role.aws_gha_role[0].arn
}

output "role_name" {
  description = "Nombre del rol IAM creado"
  value       = aws_iam_role.aws_gha_role[0].name
}

output "oidc_provider_arn" {
  description = "ARN del OIDC provider usado (creado o existente)"
  value       = local.oidc_provider_arn
}