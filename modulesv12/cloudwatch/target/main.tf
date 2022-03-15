resource "aws_cloudwatch_event_target" "target" {
  rule      = var.rule_name
  target_id = var.target_id
  arn       = var.arn
  input     = var.input_json
}


