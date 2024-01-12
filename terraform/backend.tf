terraform {
  backend "s3" {
    bucket = "terraform-backend-demo-aweber"
    key    = "terraform/state"
    region = "us-east-1"
  }
}
