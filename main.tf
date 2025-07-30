module "s3_bucket-v0" {
  source = "https://github.com/sijnal/poc-tf-modules.git//s3?ref=vpc-v1.0.0"
  bucket = "modules-s3"
}

module "s3_bucket-v3" {
  source = "https://github.com/sijnal/poc-tf-modules.git//s3?ref=s3-v3.0.0"
  bucket = "poc-tf-modules-s3"
}

module "s3_bucket-v4" {
  source = "https://github.com/sijnal/poc-tf-modules.git//s3?ref=s3-v4.0.0"
  bucket = "tf-modules-s3"
}

