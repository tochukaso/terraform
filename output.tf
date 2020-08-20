output "test-sqs-queue-url" {
  value = aws_sqs_queue.test-sqs.id
}

output "error-sqs-queue-url" {
  value = aws_sqs_queue.error-sqs.id
}