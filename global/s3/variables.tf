#Declaring variables

#Region
variable "region" {
  description = "Region the resources reside in"
  type = string
  default = "ca-central-1"
}

data "aws_vpc" "vpc_id" {
  default = true
}