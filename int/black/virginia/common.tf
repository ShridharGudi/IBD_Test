data "aws_iam_role" "pam_rds_role" {
  name = "s3-sql-backup-restore-pam"
}

resource "aws_db_subnet_group" "subnetgroup" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

    tags = {
    Name = "pam_rds_subnet_group"
  }
}
resource "aws_db_option_group" "optiongroup" {
  name                     = var.option_group_name
  option_group_description = "Terraform Option Group for sql backup restore"
  engine_name              = var.engine
  major_engine_version     = var.engine_version_option
  
  option {
    option_name = "SQLSERVER_BACKUP_RESTORE"
    option_settings {
      name  = "IAM_ROLE_ARN"
      value = data.aws_iam_role.pam_rds_role.arn
    }
  }
  
}
