module "s3_bucket" {
  source = "git@github.com:sijnal/tf-modules.git//aws/s3?ref=main"
  bucket_name = "mi-bucket-simple-sijnal"
}