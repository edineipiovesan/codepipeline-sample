resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.project-name}-bucket"
  acl    = "private"
}