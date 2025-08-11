module "s3_bucket-v0" {
  source = "./modules/s3"
  bucket = "modules-s3-test-1.1"
}

module "s3_bucket-v3" {
  source = "./module/s3"
  bucket = "module-s3-test-2"
}

module "s3_bucket-v4" {
  source = "./module/s3"
  bucket = "module-s3-test-3"
}

# module "github_actions_oidc" {
#   source = "./modules/github-actions-oidc"

#   role_name                   = "tos-dev-role-github"
#   organization                = "sijnal"
#   repository                  = "poc-ssh-modules"
#   branch                      = "main"
#   attach_administrator_policy = true
#   create_oidc_provider        = true
# }