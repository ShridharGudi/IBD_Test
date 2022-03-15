resource "aws_cloudwatch_event_rule" "rule" {
  name                = var.name
  description         = var.description
  schedule_expression = var.schedule_expression
}

output "name" {
  value = aws_cloudwatch_event_rule.rule.name
}

output "arn" {
  value = aws_cloudwatch_event_rule.rule.arn
}
