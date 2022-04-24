# We are only using AWS to pull secret data, this should be safe to use latest
provider "aws" {
  region  = "us-east-1"
}

data "aws_secretsmanager_secret" "newrelic-api" {
  arn = "arn:aws:secretsmanager:us-east-1:666665886686:secret:creds/newrelic/terraform-api-6qqO6H"
}

data "aws_secretsmanager_secret_version" "newrelic-api" {
  secret_id = data.aws_secretsmanager_secret.newrelic-api.id
}

terraform {
  required_version = ">= 0.12.31"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.30.2"
    }
  }
  experiments = [module_variable_optional_attrs]
}

provider "newrelic" {
  account_id = "86713"
  api_key = data.aws_secretsmanager_secret_version.newrelic-api.secret_string
  region = "US"
}
