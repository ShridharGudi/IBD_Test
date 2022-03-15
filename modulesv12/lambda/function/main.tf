resource "aws_lambda_function" "lambda" {
  vpc_config {
    subnet_ids = var.vpc_rds_subnet_ids
    # subnet_ids = ["${var.subnet_id_1}", "${var.subnet_id_2}", "${var.subnet_id_3}"]
    security_group_ids = [
      var.vpc_rds_security_group_id,
      var.sg_lambda_mysql,
    ]
  }

  filename         = "${var.file_path}${var.file_name}.zip"
  function_name    = var.function_name
  role             = var.iam_role_arn
  handler          = "${var.file_name}.lambda_handler"
  source_code_hash = filebase64sha256("${var.file_path}${var.file_name}.zip")
  runtime          = "python3.6"
  timeout          = 60

  tags = var.tags
}

resource "aws_lambda_permission" "pam_permission" {
  statement_id  = var.statement_id
  action        = var.action
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule.arn
  depends_on    = [aws_lambda_function.lambda]
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "function_name" {
  value = var.function_name
}

# Rule

resource "aws_cloudwatch_event_rule" "rule" {
  name                = var.rule_name
  description         = var.rule_description
  schedule_expression = var.rule_schedule_expression
  is_enabled = var.is_enabled
}

# Target
resource "aws_cloudwatch_event_target" "target" {
  rule      = var.rule_name
  target_id = var.target_id
  arn       = aws_lambda_function.lambda.arn
  input     = var.target_input_json
}
