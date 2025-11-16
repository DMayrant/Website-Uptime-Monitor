resource "aws_sns_topic" "uptime_alerts" {
  name = "uptime-alerts"
}

resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.uptime_alerts.arn
  protocol  = "sms"
  endpoint  = "+15551234567" 
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-uptime-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy" "lambda_sns_policy" {
  name = "lambda-sns-publish-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect: "Allow",
      Action: [
        "sns:Publish"
      ],
      Resource: aws_sns_topic.uptime_alerts.arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sns_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_sns_policy.arn
}




