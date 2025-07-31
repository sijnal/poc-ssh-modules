# Data source para verificar si el OIDC provider ya existe
data "aws_iam_openid_connect_provider" "existing_github_oidc" {
  count = var.create_oidc_provider ? 0 : 1
  url   = "https://token.actions.githubusercontent.com"
}

# Crear OIDC provider solo si no existe y se solicita crear
resource "aws_iam_openid_connect_provider" "github_oidc" {
  count = var.create_oidc_provider ? 1 : 0
  url   = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = var.thumbprint_list
}

# Variable local para obtener el ARN del OIDC provider (existente o nuevo)
locals {
  oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.github_oidc[0].arn : data.aws_iam_openid_connect_provider.existing_github_oidc[0].arn
}

data "aws_iam_policy_document" "aws_gha_assume_role" {
  count = var.role_name == null ? 0 : 1
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.organization}/${var.repository}:ref:refs/heads/${var.branch}"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "aws_gha_role" {
  count              = var.role_name == null ? 0 : 1
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.aws_gha_assume_role[0].json
}

resource "aws_iam_role_policy" "administrator_access_policy" {
  count = var.attach_administrator_policy ? 1 : 0
  name  = "administrator_access_policy"
  role  = aws_iam_role.aws_gha_role[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}