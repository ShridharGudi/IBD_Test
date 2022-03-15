variable "allocated_storage" {
  default = 200
}
variable "backup_retention_period" {
  default = 7
}
variable "db_subnet_group_name" {
  default = "pam-rds-subnet-group-blue"
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
  default = "13.00.4422.0.v1"
}
variable "engine_version_option" {
  default = "13.00"
}
variable "instance_class" {
  default = "db.m4.large"
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
  default = true
}

variable "port" {
  default = 1433
}
variable "option_group_name" {
  default = "pam-rds-option-blue"
}

variable "storage_encrypted" {
  default = false
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
    default = ["sg-617e4c10"]
  type = "list"
}
variable "subnet_ids" {
    default = ["subnet-f1a190dc","subnet-00e9c55b","subnet-1505e45d"]
  type = "list"
}
# variable "monitoring_role_arn" {
#   default = ""
# }
# variable "monitoring_interval" {
#   default = ""
# }
variable "tags" {

  default = {
    owner = "immanuel.gnanadurai@dowjones.com"
    component = "core"
    environment = "int"
    product     = "factiva"
    bu          =  "djin"
    servicename = "djin/factiva/core"
    Name    = "PAMDB"
  }

 type="map"
}
variable "timezone" {
  default = "Eastern Standard Time"
}
variable "availability_zone" {
  default = "us-east-1b"
}
variable "identifier" {
  default = "virqinpamsdb-blue"
}


variable "env" {
    description = "Environment"
    default = "INT"
}

variable "aws_region" {
    description = "Default Region for the VPC"
    default = "us-east-1"
}

