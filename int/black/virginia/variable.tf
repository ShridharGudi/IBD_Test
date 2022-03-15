variable "aws_region" {
    description = "Default Region for the VPC"
    default = "us-east-1"
}
variable "option_group_name" {
  default = "pam-rds-option-2016"
}
variable "db_subnet_group_name" {
  default = "pam-rds-subnet-group-2016"
}
variable "subnet_ids" {
  default = ["subnet-f1a190dc","subnet-00e9c55b","subnet-1505e45d"]
  type = list
}
variable "engine_version_option" {
  default = "13.00"
}
variable "engine" {
  default = "sqlserver-se"
}