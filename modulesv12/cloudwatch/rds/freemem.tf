//DB Free Memory
resource "aws_cloudwatch_metric_alarm" "FreeMem" {
  alarm_name = "djin-${var.env}-${var.alarm_name}-RDS-FreeMemory"
  alarm_description = "${upper("${var.alarm_name}")} ${upper("${var.env}")} RDS Free Memory"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = var.AllocatedMemoryInGB * 0.20 * 1000000000
  treat_missing_data        = "missing"

 dimensions = { 
    DBInstanceIdentifier  = var.rds_name
  }
  alarm_actions = ["arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.sns_topic}"]  
}