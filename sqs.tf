resource "aws_sqs_queue" "test-sqs" {
  # FIFO queue name shoud end with ".fifo"
  name                      = "test-sqs.fifo"
  fifo_queue                = true
  # メッセージの内容が重複している場合に排除するかどうか。
  # trueにしない場合、メッセージ送信時にグループIDも送信する必要が出て来る。
  content_based_deduplication = true
  # メッセージが保持される日数(デフォルトは4日)
  message_retention_seconds = 86400

  # 可視性タイムアウトの秒数.デフォルトは30秒
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.test-sqs-deadletter.arn
    maxReceiveCount     = 4
  })

  tags = local.common-tags
}

resource "aws_sqs_queue" "test-sqs-deadletter" {
  name                      = "test-sqs-deadletter.fifo"
  fifo_queue                = true
  content_based_deduplication = true
  message_retention_seconds = 1209600
  tags                      = local.common-tags
}
