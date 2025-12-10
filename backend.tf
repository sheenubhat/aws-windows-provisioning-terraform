//stores terraform state file remotely

terraform {
    backend "s3" {
        bucket = ""
        key = "poc.tfstate"
        region = "us-east-1"
        dynamodb_table = ""
        encrypt = true
    }
}