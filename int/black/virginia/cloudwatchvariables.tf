variable "db_event_db_instance_names" {
  default = ["virpinpamdb-blue","virpinpamdb-blue"]
  type = list
}

variable "aws_cloudwatch_alarm_db_instance_name_blue" {
    default = "virpinpamdb-blue"  
}

variable "aws_cloudwatch_alarm_db_instance_name_green" {
    default = "virpinpamdb-green"  
}

# variable "aws_cloudwatch_alarm_elb_blue" {
#     default = "djin-prod-pam-blue"  
# }

# variable "aws_cloudwatch_alarm_elb_green" {
#     default = "djin-prod-pam-green"  
# }
