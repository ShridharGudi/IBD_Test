variable "vpc_rds_subnet_ids" {
  default = ["subnet_ids"]
}

variable "subnet_id_1" {
  default = "subnet1"
}

variable "subnet_id_2" {
  default = "subnet2"
}

variable "subnet_id_3" {
  default = "subnet2"
}

variable "vpc_rds_security_group_id" {
  default = "sg_id"
}

variable "sg_lambda_mysql" {
  default = "lambda sg id"
}

variable "file_name" {
  default = "file_name"
}

variable "file_path" {
  default = "file path"
}

variable "function_name" {
  default = "function_name"
}

variable "iam_role_arn" {
  default = "iam_role"
}

variable "tags" {
  type        = "list"
  description = "list of tags"
}

variable "statement_id" {
  default = "statement_id"
}

variable "action" {
  default = "action"
}

variable "source_arn" {
  default = "sourcearn"
}

# Rule vars
variable "rule_name" {
  default = "name"
}

variable "rule_description" {
  default = "description"
}

variable "rule_schedule_expression" {
  default = "schedule_expression"
}

# Target Vars
variable "target_id" {
  default = "target_id"
}

variable "target_input_json" {
  default = "{}"
}

variable "is_enabled" {
  default = "false"
}