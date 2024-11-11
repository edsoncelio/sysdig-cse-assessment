terraform {
  backend "s3" {
    bucket         = "tf-state-sandbox"
    key            = "terraform/sysdig-integration/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"
  }
}