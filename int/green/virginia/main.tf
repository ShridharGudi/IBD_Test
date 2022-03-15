// Configure the Google Cloud provider / AWS Cloud provider

provider "aws" {
  region  = var.aws_region
}

terraform {  
  required_version = "~> 1.0"  
  backend "artifactory" {}
}

resource "random_uuid" "tf-upgraded2" {
}

data "aws_db_snapshot" "latest_snapshot" {
  most_recent            = true
  db_instance_identifier = "awsifpamdb-blue"
}

resource "aws_db_instance" "awsifpamdb-green" {
  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = var.db_subnet_group_name
  engine                  = var.engine
  engine_version          = var.engine_version
  identifier              = var.identifier
  instance_class          = var.instance_class
  multi_az                = var.multi_az

  #name                         = "${var.name}"
  parameter_group_name        = var.parameter_group_name
  password                    = var.password
  port                        = var.port
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  storage_encrypted           = var.storage_encrypted
  storage_type                = var.storage_type
  username                    = var.username
  option_group_name           = var.option_group_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  license_model               = var.license_model
  allow_major_version_upgrade = var.allow_major_version_upgrade

  #snapshot_identifier         = data.aws_db_snapshot.latest_snapshot.id
  snapshot_identifier       = "awsifpamdb-encrypted-blue-2021-09-07-06-23"
  skip_final_snapshot       = "false"
  final_snapshot_identifier = "${var.final_snapshot_identifier}-${substr(timestamp(), 0, 10)}-${substr(timestamp(), 11, 2)}-${substr(timestamp(), 14, 2)}"
  tags                      = var.tags
  timezone                  = var.timezone
  monitoring_interval       = var.enhanced_monitoring_interval
  monitoring_role_arn       = var.monitoring_role

  #availability_zone           = "${var.availability_zone}"
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_in_days
  #availability_zone           = "${var.availability_zone}"
    apply_immediately           = "true"
  lifecycle{
    ignore_changes = [
    snapshot_identifier,
    ]
  } 
}

resource "null_resource" "changerdspassword-1" {
  provisioner "local-exec" {
    command = "pamdb=$(aws ssm get-parameters --output text --with-decryption --names ${var.password_key} --region ${var.aws_region} | awk '{print $(NF-1)}');aws rds modify-db-instance --db-instance-identifier awsifpamdb-green  --master-user-password $pamdb --region ${var.aws_region} --apply-immediately"
  }

  depends_on = [aws_db_instance.awsifpamdb-green]
}

