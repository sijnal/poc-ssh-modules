# module "s3_bucket-v0" {
#   source = "git::https://github.com/sijnal/poc-tf-modules.git//s3?ref=vpc-v1.0.0"
#   bucket = "modules-s3"
# }

# module "s3_bucket-v3" {
#   source = "git::https://github.com/sijnal/poc-tf-modules.git//s3?ref=s3-v3.0.0"
#   bucket = "poc-tf-modules-s3"
# }

module "s3_bucket-v4" {
  source = "git::https://github.com/sijnal/poc-tf-modules.git//s3?ref=s3-v4.0.0"
  bucket = "poc-ssh-modules-s3"
}

module "github_actions_oidc" {
  source = "./modules/github-actions-oidc"
  
  role_name = "tos-dev-role-github"
  organization = "sijnal"
  repository = "poc-ssh-modules"
  branch = "main"
  attach_administrator_policy = true
}