terraform {
  backend "s3" {
    bucket         = "edn.tf-state" # Your S3 bucket here
    key            = "terraform/state/codepipeline-sample"
    region         = "us-east-1"
    dynamodb_table = "edn.tf-lock" # Your DynamoDB lock table here
  }
}