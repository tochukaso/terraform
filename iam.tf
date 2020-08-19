resource "aws_iam_role" "consumer-sqs-role" {
  name               = "consumer-sqs-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-trust-rel-policy.json
}

resource "aws_iam_policy" "consumer-sqs-role-policy" {
  name   = "consumer-sqs-role-policy"
  policy = data.aws_iam_policy_document.consumer-sqs-role-policy.json
}

resource "aws_iam_role_policy_attachment" "attach-consumer-sqs" {
  role       = aws_iam_role.consumer-sqs-role.name
  policy_arn = aws_iam_policy.consumer-sqs-role-policy.arn
}
