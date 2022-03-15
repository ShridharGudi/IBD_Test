module "cloudwatch_pam_rds_alarm_CPUAlarm" {
  source               = "../../../modulesv12/cloudwatch/rds"
  env                  = var.env
  aws_region           = var.aws_region
  sns_topic            = "hercules-clowdwatch-rds-events"
  sns_topic_dba        = "dba-clowdwatch-rds-events"
  rds_name             = var.identifier
  alarm_name           = "PAM-Green-CloudWatch-Alarm"
  AllocatedStorageInGB = var.allocated_storage
  AllocatedMemoryInGB  = var.allocated_memory
}

# module "cloudwatch_pam_rds_alarm_DBConnAlarm" {
#   source            = "git::https://github.dowjones.net/djin-infrastructure/djin_amodules_platform//cloudwatch/rds/"
#   env               = "${var.env}"
#   aws_region        = "${var.region}"
#   sns_topic         = "hercules-clowdwatch-rds-events"
#   rds_name          = "${var.identifier}"
#   alarm_name        = "PAM-CloudWatch-Alarm"
# }
# module "cloudwatch_rds_alarm_FreeMemAlarm" {
#   source            = "git::https://github.dowjones.net/djin-infrastructure/djin_amodules_platform//cloudwatch/rds/"
#   env               = "${var.env}"
#   aws_region        = "${var.region}"
#   sns_topic         = "hercules-clowdwatch-rds-events"
#   rds_name          = "${var.identifier}"
#   alarm_name        = "PAM-CloudWatch-Alarm"
# }
# module "cloudwatch_pam_rds_alarm_FreeStorageAlarm" {
#   source            = "git::https://github.dowjones.net/djin-infrastructure/djin_amodules_platform//cloudwatch/rds/"
#   env               = "${var.env}"
#   aws_region        = "${var.region}"
#   sns_topic         = "hercules-clowdwatch-rds-events"
#   rds_name          = "${var.identifier}"
#   alarm_name        = "PAM-CloudWatch-Alarm"
# }
