terraform {
  backend "s3" {
    bucket  = "tf-state-phardy"
    key     = "prod/datastores/mysql/terraform.tfstate"
    region  = "ca-central-1"
    encrypt = true
  }
}

resource "aws_db_instance" "backend-db" {
  allocated_storage = 10
  identifier_prefix = "backenddb-prod"
  engine = "mysql"
  instance_class = "db.t2.micro"
  skip_final_snapshot = true
  db_name = "backenddb-prod"
  username = var.db_username
  password = var.db_password
}