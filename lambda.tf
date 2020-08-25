resource "aws_lambda_function" "consumer-sqs" {
  filename         = data.archive_file.consumer-sqs.output_path
  function_name    = "consumer-sqs"
  role             = aws_iam_role.consumer-sqs-role.arn
  handler          = "index.handle"
  source_code_hash = data.archive_file.consumer-sqs.output_base64sha256
  runtime          = "nodejs12.x"
  memory_size      = 256
  timeout          = 30

}

resource "aws_lambda_event_source_mapping" "consumer-sqs" {
  event_source_arn = aws_sqs_queue.test-sqs.arn
  enabled          = true
  function_name    = aws_lambda_function.consumer-sqs.arn
  batch_size       = 1
}

resource "aws_lambda_event_source_mapping" "consumer-sqs2" {
  event_source_arn = aws_sqs_queue.test-sqs2.arn
  enabled          = true
  function_name    = aws_lambda_function.consumer-sqs.arn
  batch_size       = 1
}

resource "null_resource" "consumer-sqs" {
  triggers = {
    version = "0.0.1"
  }
}

resource "aws_lambda_function" "dead-letter-sqs" {
  filename         = data.archive_file.dead-letter-sqs.output_path
  function_name    = "dead-letter-sqs"
  role             = aws_iam_role.consumer-sqs-role.arn
  handler          = "index.handle"
  source_code_hash = data.archive_file.dead-letter-sqs.output_base64sha256
  runtime          = "nodejs12.x"
  memory_size      = 256
  timeout          = 30

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.error-sqs.id
    }
  }
}

resource "aws_lambda_event_source_mapping" "dead-letter-sqs" {
  event_source_arn = aws_sqs_queue.test-sqs-deadletter.arn
  enabled          = true
  function_name    = aws_lambda_function.dead-letter-sqs.arn
  batch_size       = 1
}

resource "aws_lambda_event_source_mapping" "dead-letter-sqs2" {
  event_source_arn = aws_sqs_queue.test-sqs2-deadletter.arn
  enabled          = true
  function_name    = aws_lambda_function.dead-letter-sqs.arn
  batch_size       = 1
}

resource "null_resource" "dead-letter-sqs" {
  triggers = {
    version = "0.0.1"
  }
}
