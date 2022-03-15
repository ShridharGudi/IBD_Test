# # create RDS events subscription
# resource "aws_sns_topic" "teamherculessns" {
#   name = "hercules-clowdwatch-rds-events"
# }
# resource "aws_sns_topic" "teamherculesdbssns" {
#   name = "hercules-dba-clowdwatch-rds-events"
# }
# resource "null_resource" "subscribeToTopichercles1" {
#   provisioner "local-exec" {
#     command = "aws sns subscribe --topic-arn ${aws_sns_topic.teamherculessns.arn} --protocol email --notification-endpoint teamhercules@dowjones.com --region ${var.aws_region}" 
#   }
# }

# resource "null_resource" "subscribeToTopichercles2" {
#   provisioner "local-exec" {
#     command = "aws sns subscribe --topic-arn ${aws_sns_topic.teamherculesdbssns.arn} --protocol email --notification-endpoint DBAs-SQL@dowjones.com --region ${var.aws_region}" 
#   }
# }
# # Subscribe to db events
# resource "aws_db_event_subscription" "pam_subscribe_rds_events" {
#   name      = "pam-rds-events-subscription"
#   sns_topic = "${aws_sns_topic.teamherculessns.arn}"

#   source_type = "db-instance"
#   source_ids  = ["virsinpamdb-blue"]
 
#   event_categories = [
#     "availability",
#     "deletion",
#     "failover",
#     "failure",
#     "low storage",
#     "maintenance",
#     "notification",
#     "recovery",
#     "restoration"
#   ]
# }

# resource "aws_sns_topic_policy" "teamherculessnspolicy" {
#   arn = "${aws_sns_topic.teamherculessns.arn}"

#   policy = <<POLICY
#   {
#     "Version": "2012-10-17",
#     "Id": "default",
#     "Statement":[{
#     "Sid": "default",
#     "Effect": "Allow",
#     "Principal": {"AWS":"*"},
#     "Action": [
#       "SNS:GetTopicAttributes",
#       "SNS:SetTopicAttributes",
#       "SNS:AddPermission",
#       "SNS:RemovePermission",
#       "SNS:Publish",
#       "SNS:DeleteTopic"
#     ],
#     "Resource": "${aws_sns_topic.teamherculessns.arn}"
#     }]
#   }
#   POLICY
# }