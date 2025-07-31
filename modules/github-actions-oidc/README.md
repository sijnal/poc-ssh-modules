# Módulo GitHub Actions OIDC

Este módulo de Terraform crea un OIDC provider (opcional) y un rol IAM para permitir que GitHub Actions se autentique con AWS usando OpenID Connect.

## Características

- Crea un OIDC provider para GitHub Actions (opcional)
- Reutiliza un OIDC provider existente si ya existe
- Crea un rol IAM con política de asunción configurada para OIDC
- Opcionalmente adjunta una política de administrador
- Configurable para múltiples repositorios y ramas

## Uso Básico

```hcl
# Primer módulo - crea el OIDC provider
module "github_actions_oidc_main" {
  source = "./modules/github-actions-oidc"
  
  create_oidc_provider = true  # Solo este crea el OIDC provider
  role_name = "main-repo-github-role"
  organization = "sijnal"
  repository = "poc-tf-modules"
  branch = "main"
  attach_administrator_policy = true
}

# Segundo módulo - usa el OIDC provider existente
module "github_actions_oidc_secondary" {
  source = "./modules/github-actions-oidc"
  
  create_oidc_provider = false  # Usa el OIDC provider existente
  role_name = "secondary-repo-github-role"
  organization = "sijnal"
  repository = "otro-repositorio"
  branch = "develop"
  attach_administrator_policy = false
}
```

## Variables

| Nombre | Descripción | Tipo | Default | Requerido |
|--------|-------------|------|---------|-----------|
| create_oidc_provider | Si crear el OIDC provider o usar uno existente | bool | false | no |
| thumbprint_list | Thumbprints para el OIDC provider | list(string) | ["2b18947a6a9fc7764fd8b5fb18a863b0c6dac24f"] | no |
| role_name | Nombre del rol IAM | string | null | sí |
| organization | Nombre de la organización de GitHub | string | null | sí |
| repository | Nombre del repositorio de GitHub | string | null | sí |
| branch | Nombre de la rama de GitHub | string | null | sí |
| attach_administrator_policy | Si adjuntar política de administrador | bool | false | no |

## Outputs

| Nombre | Descripción |
|--------|-------------|
| role_arn | ARN del rol IAM creado |
| role_name | Nombre del rol IAM |
| oidc_provider_arn | ARN del OIDC provider usado |

## Uso en GitHub Actions

Para usar este rol en GitHub Actions, agrega esto a tu workflow:

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
    aws-region: us-east-1
```

Donde `AWS_ROLE_ARN` es el valor del output `role_arn`.

## Notas Importantes

- **Solo un módulo debe tener `create_oidc_provider = true`** en toda tu infraestructura
- Los demás módulos deben usar `create_oidc_provider = false` para reutilizar el OIDC provider existente
- El OIDC provider se crea una sola vez y se reutiliza para todos los roles 