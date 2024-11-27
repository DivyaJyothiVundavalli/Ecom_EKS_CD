terraform {
  backend "s3" {
    bucket = "ecomappbucket"
    key    = "eks/terraform.tfstate"
    region = "us-east-2"
  }
}