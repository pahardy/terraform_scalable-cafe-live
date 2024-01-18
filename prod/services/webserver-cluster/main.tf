terraform {
  backend "s3" {
    bucket  = "tf-state-phardy"
    key     = "prod/webserver-cluster/terraform.tfstate"
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

  cluster_name = "webservers-prod"
  db_remote_state_bucket = "tf-state-phardy"
  db_remote_state_key = "prod/datastores/mysql/terraform.tfstate"

  instance_type = "t3.small"
  asg-min = 3
  asg-max = 10
  asg-desired = 5
}

resource "aws_autoscaling_schedule" "prod-scale-out-business-hours" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name  = "business-hours-scaleout"
  min_size = 2
  max_size = 10
  desired_capacity = 5
  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "prod-scale-in-after-business-hours" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name  = "after-hours-scalein"
  min_size = 2
  max_size = 10
  desired_capacity = 3
  recurrence = "0 17 * * *"
}