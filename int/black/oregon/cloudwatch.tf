#Subscribe to db events
data "aws_sns_topic" "default" {
  name = "hercules-app-events-int"
}

resource "aws_db_event_subscription" "default" {
  name      = "rds-event-prod-sub"
  sns_topic = "${aws_sns_topic.default.arn}"

  source_type = "db-instance"
  source_ids  = "${var.db_event_db_instance_names}"
 
  event_categories = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
}




#generate cloud watch metrics alarm

resource "aws_cloudwatch_metric_alarm" "PAMRDSCPUAlarmgreen" {
  alarm_name                = "RDS CPU Alarm-Green"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "60"
  treat_missing_data          =  "ignore"
  alarm_description         = "This metric monitors RDS cpu utilization"
 dimensions {
    DBInstanceIdentifier  = "${var.aws_cloudwatch_alarm_db_instance_name_green}"
  }
  alarm_actions = [ "${aws_sns_topic.default.arn}"]

}

// generate cloud watch metrics alarm

resource "aws_cloudwatch_metric_alarm" "PAMRDSCPUAlarmblue" {
  alarm_name                = "RDS CPU Alarm-Blue"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "60"
  treat_missing_data          =  "ignore"
  alarm_description         = "This metric monitors RDS cpu utilization"
 dimensions {
    DBInstanceIdentifier  = "${var.aws_cloudwatch_alarm_db_instance_name_blue}"
  }
  alarm_actions = [ "${aws_sns_topic.default.arn}"]

}

#generate alaram for select latency
resource "aws_cloudwatch_metric_alarm" "PAMRDSSelectLatencygreen" {
  alarm_name                = "RDS CPU Alarm-Green"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "SelectLatency"
  namespace                 = "AWS/RDS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "500"
  treat_missing_data          =  "ignore"
  alarm_description         = "This metric monitors RDS SELECT Latency"
 dimensions {
    DBInstanceIdentifier  = "${var.aws_cloudwatch_alarm_db_instance_name_green}"
  }
  alarm_actions = [ "${aws_sns_topic.default.arn}"]

}

//generate alaram for select latency
resource "aws_cloudwatch_metric_alarm" "PAMRDSSelectLatencyblue" {
  alarm_name                = "RDS CPU Alarm-Blue"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "SelectLatency"
  namespace                 = "AWS/RDS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "500"
  treat_missing_data          =  "ignore"
  alarm_description         = "This metric monitors RDS SELECT Latency"
 dimensions {
    DBInstanceIdentifier  = "${var.aws_cloudwatch_alarm_db_instance_name_blue}"
  }
  alarm_actions = [ "${aws_sns_topic.default.arn}"]

}
