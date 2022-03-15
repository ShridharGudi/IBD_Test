variable "allocated_storage" {
  default = 100
}
variable "allocated_memory" {
  default = 30
}
variable "backup_retention_period" {
  default = 3
}
variable "db_subnet_group_name" {
  default = "pam-rds-subnet-group-2016"
}
variable "multi_az" {
  default = false
}
variable "username" {
  default = "DBAdmin"
}
variable "password" {
  default = "Factiva123"
}
variable "engine" {
  default = "sqlserver-se"
}
variable "engine_version" {
  default = "13.00.5882.1.v1"
}
variable "performance_insights_enabled" {
  default = "true"
}
variable "performance_insights_retention_in_days" {
  default = "7"
}


variable "engine_version_option" {
  default = "13.00"
}
variable "instance_class" {
  default = "db.r4.large"
}
variable "domain" {
  default = "fint.awsad.net"
}
variable "domainiamrolename" {
  default = "rds-directoryservice-access-role"
}
variable "parameter_group_name" {
  default = "default.sqlserver-se-13.0"
}
variable "copy_tags_to_snapshot" {
  default = true
}
variable "storage_type" {
  default = "gp2"
}
variable "auto_minor_version_upgrade" {
  default = false
}
variable "enhanced_monitoring_interval" {
  default = 1
}
variable "password_key" {
  description = "Master password change after instance up"
  default = "pamsqladmin"
}
variable "port" {
  default = 1433
}
variable "option_group_name" {
  default = "pam-rds-option-2016"
}

variable "storage_encrypted" {
  default = true
}

variable "license_model" {
  default = "license-included"
}
variable "allow_major_version_upgrade" {
  default = false
}
variable "skip_final_snapshot" {
  default = false
}
variable "final_snapshot_identifier" {
  default = "pam-final-blue"
}
variable "vpc_security_group_ids" {
    default = ["sg-617e4c10","sg-82aad7fc"]
  type    = list(string)
}
variable "subnet_ids" {
    default = ["subnet-f1a190dc","subnet-00e9c55b","subnet-1505e45d"]
  type    = list(string)
}

variable "tags" {

  default = {
    owner = "teamhercules@dowjones.com"
    component = "assets"
    environment = "int"
    product     = "platform"
    bu          =  "djin"
    tier         = "db"
    Name    = "PAMDB"
    appid = "in_platform_assets"
  }

 type = map(string)
}
variable "timezone" {
  default = "Eastern Standard Time"
}
variable "availability_zone" {
  default = "us-east-1b"
}
variable "identifier" {
  default = "awsifpamdb-blue"
}


variable "env" {
    description = "Environment"
    default = "int"
}

variable "aws_region" {
    description = "Default Region for the VPC"
    default = "us-east-1"
}
variable "vpc_name" {
  default = "pib*"
}
variable "file_path" {
  default = "../../../utils/lambda/"
}
variable "create_snapshot_lambda_file_name" {
  default = "pam_snapshot_create_lambda"
}
variable "delete_snapshot_lambda_file_name" {
  default = "pam_snapshot_delete_lambda"
}
variable "create_snapshot_lambda_function_name" {
  default = "pamrds-create-snapshot"
}
variable "delete_snapshot_lambda_function_name" {
  default = "pamrds-delete-snapshot"
}
variable site_color {
  default = "blue"
}
variable "iam_role" {
  default = "djin-pamrds-dr"
}
variable "sg_standard" {
  default = "djin_standard"
}
variable "pam_rds" {
  default = "pam_rds"
}
variable "environment_name" {
  description = "The name of the environment"
  default     = "prod"
}
variable "owner" {
  default = "teamhercules@dowjones.com"
}
variable "bu" {
  default = "djin"
}
variable "product" {
  default = "platform"
}
variable "component" {
  default = "assets"
}
variable "servicename" {
  default = "djin/platfrom/assets/pam"
}
#needs to change once EP team create new role
variable "iam_role_lambda" {
  default = "djin-pamrds-dr"
}
variable "copy_snapshot_lambda_file_name" {
  default = "pam_snapshot_copy_lambda"
}
variable "restore_snapshot_lambda_file_name" {
  default = "pam_snapshot_restore_lambda"
}
variable "copy_snapshot_lambda_function_name" {
  default = "pamrds-copy-snapshot"
}
variable "restore_snapshot_lambda_function_name" {
  default = "pamrds-restore-snapshot"
}
variable "delete_rdsinstance_lambda_file_name" {
  default = "pam_rdsinstance_delete_lambda"
}
variable "delete_rdsinstance_lambda_function_name" {
  default = "pamrds-rdsinstance-delete"
}
//restore_snapshot set time and enabled/disabled
variable "restore_snapshot_time" {
  default = "rate(364 days)"
}
variable "restore_snapshot_is_enabled" {
  default = "false"
}
//create_snapshot set time and enabled/disabled
variable "create_snapshot_time" {
  default = "rate(6 hours)"
}
variable "create_snapshot_is_enabled" {
  default = "true"
}
//delete_snapshot set time and enabled/disabled
variable "delete_snapshot_time" {
  default = "rate(24 hours)"
}
variable "delete_snapshot_is_enabled" {
  default = "true"
}
//copy_snapshot set time and enabled/disabled
variable "copy_snapshot_time" {
  default = "rate(1 hour)"
}
variable "copy_snapshot_is_enabled" {
  default = "false"
}
//rdsinstance-delete set time and enabled/disabled
variable "rdsinstance-delete_time" {
  default = "rate(364 days)"
}
variable "rdsinstance-delete_is_enabled" {
  default = "false"
}
variable "monitoring_role" {
  description = "Iam Role for Enhanced Montoring"
  default = "arn:aws:iam::506312309551:role/rds_monitoring_role"
}

