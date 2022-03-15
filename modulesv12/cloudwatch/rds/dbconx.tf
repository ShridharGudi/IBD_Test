
resource "aws_cloudwatch_metric_alarm" "DBConn" {
  alarm_name = "djin-${var.env}-${var.alarm_name}-RDS-DBConn"
  alarm_description = "${upper("${var.alarm_name}")} ${upper("${var.env}")} RDS DB Connections"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "DatabaseConnections"
  namespace                 = "AWS/RDS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "300"
  treat_missing_data        = "missing"

  dimensions = { 
    DBInstanceIdentifier  = var.rds_name
  }
  alarm_actions = ["arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.sns_topic}"]  
}