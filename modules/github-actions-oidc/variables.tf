variable "create_oidc_provider" {
  description = "Si se debe crear el OIDC provider (true) o usar uno existente (false)"
  type        = bool
  default     = false
}

variable "thumbprint_list" {
  description = "Lista de thumbprints para el OIDC provider de GitHub (solo se usa si create_oidc_provider = true)"
  type        = list(string)
  default     = ["2b18947a6a9fc7764fd8b5fb18a863b0c6dac24f"]
}

variable "role_name" {
  description = "Nombre del rol IAM para GitHub Actions"
  type        = string
  default     = null
}

variable "organization" {
  description = "Nombre de la organización de GitHub"
  type        = string
  default     = null
}

variable "repository" {
  description = "Nombre del repositorio de GitHub"
  type        = string
  default     = null
}

variable "branch" {
  description = "Nombre de la rama de GitHub"
  type        = string
  default     = null
}

variable "attach_administrator_policy" {
  description = "Si se debe adjuntar la política de administrador al rol"
  type        = bool
  default     = false
}

 