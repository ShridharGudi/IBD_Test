// Configure the Google Cloud provider / AWS Cloud provider

provider "aws" {
  region = "${var.aws_region}"
}
terraform {
  backend "artifactory" {}
}
resource "aws_db_subnet_group" "subnetgroup" {
  name       = "${var.db_subnet_group_name}"
  subnet_ids = "${var.subnet_ids}"

  tags {
    Name = "pam_rds_subnet_group"
  }
}
data "aws_iam_role" "pam_rds_role" {
  role_name = "s3-sql-backup-restore-pam"
}
resource "aws_db_option_group" "optiongroup" {
  name                     = "${var.option_group_name}"
  option_group_description = "Terraform Option Group for sql backup restore"
  engine_name              = "${var.engine}"
  major_engine_version     = "${var.engine_version_option}"

  option {
    option_name = "SQLSERVER_BACKUP_RESTORE"
    option_settings {
      name  = "IAM_ROLE_ARN"
      value = "${data.aws_iam_role.pam_rds_role.arn}"
    }
  }
  

}

resource "aws_db_instance" "virqinpamsdb-blue" {  
  allocated_storage           = "${var.allocated_storage}"
  backup_retention_period     = "${var.backup_retention_period}"
  db_subnet_group_name        = "${aws_db_subnet_group.subnetgroup.name}"
  engine                      = "${var.engine}"
  engine_version              = "${var.engine_version}"
  identifier                  = "${var.identifier}"
  instance_class              = "${var.instance_class}"
  multi_az                    = "${var.multi_az}"
  #name                         = "${var.name}"
  parameter_group_name        = "${var.parameter_group_name}" 
  password                    = "${var.password}"
  port                        = "${var.port}"
  copy_tags_to_snapshot       =  "${var.copy_tags_to_snapshot}"
  storage_encrypted           = "${var.storage_encrypted}"
  storage_type                = "${var.storage_type}"
  username                    = "${var.username}"
  option_group_name           = "${aws_db_option_group.optiongroup.name}"
  vpc_security_group_ids      = "${var.vpc_security_group_ids}"
  license_model               = "${var.license_model}"
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  skip_final_snapshot         = "false"
  final_snapshot_identifier   =  "${var.final_snapshot_identifier}"
  # domain                      = "${var.domain}"
  # domain-iam-role-name        =  "${var.domainiamrolename}"
  # monitoring_role_arn     = "${var.monitoring_role_arn}"
  # monitoring_interval         = "${var.monitoring_interval}"
  tags                        = "${var.tags}"
  timezone                    = "${var.timezone}"
  #availability_zone           = "${var.availability_zone}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
}


resource "null_resource" "ms-ad" {

  provisioner "local-exec" {
    command = "aws modify-db-instance --db-instance-identifier ${var.identifier} --domain fint.awsad.net --domain-iam-role-name ${data.aws_iam_role.pam_rds_role.arn}"
}