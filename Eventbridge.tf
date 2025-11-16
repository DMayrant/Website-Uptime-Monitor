resource "aws_cloudwatch_event_rule" "uptime_schedule" {
  name                = "uptime-check-every-5-mins"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "uptime_target" {
  rule      = aws_cloudwatch_event_rule.uptime_schedule.name
  target_id = "uptimeLambda"
  arn       = aws_lambda_function.lambda_uptime.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_uptime.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.uptime_schedule.arn
}
