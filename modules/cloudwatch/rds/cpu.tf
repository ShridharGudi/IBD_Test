variable "env" {}
variable "aws_region" {}
variable "sns_topic" {}
variable "sns_topic_dba" {}
variable "alarm_name" {}
variable "rds_name" {}
variable "AllocatedStorageInGB" {}
variable "AllocatedMemoryInGB" {}
data "aws_caller_identity" "current" {}

//Hign CPU
resource "aws_cloudwatch_metric_alarm" "CPUAlarm" {
  alarm_name = "djin-${var.env}-${var.alarm_name}-RDS-HighCPU"
  alarm_description = "${upper("${var.alarm_name}")} ${upper("${var.env}")} RDS high CPU"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "70"

 dimensions {
    DBInstanceIdentifier  = "${var.rds_name}"
  }
  alarm_actions = ["arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.sns_topic}"]  
 

}

//Very Hign CPU
resource "aws_cloudwatch_metric_alarm" "VHighCPUAlarm" {
  alarm_name = "djin-${var.env}-${var.alarm_name}-RDS-VeryHighCPU"
  alarm_description = "${upper("${var.alarm_name}")} ${upper("${var.env}")} RDS high CPU"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "90"

 dimensions {
    DBInstanceIdentifier  = "${var.rds_name}"
  }
  alarm_actions = ["arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.sns_topic_dba}"]  

}