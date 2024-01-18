terraform {
  backend "s3" {
    bucket  = "tf-state-phardy"
    key     = "stage/webserver-cluster/terraform.tfstate"
    region  = "ca-central-1"
    encrypt = true
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "ca-central-1"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name = "webservers-stage"
  db_remote_state_bucket = "tf-state-phardy"
  db_remote_state_key = "stage/datastores/mysql/terraform.tfstate"

  instance_type = "t3.small"
  asg-min = 2
  asg-max = 3
  asg-desired = 3
}