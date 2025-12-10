//stores terraform state file remotely

terraform {
    backend "s3" {
        bucket = "value"
        key = "poc.tfstate"
        region = "us-east-1"
        dynamodb_table = "value"
        encrypt = true
    }
}