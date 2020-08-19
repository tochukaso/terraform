data "aws_iam_policy_document" "lambda-trust-rel-policy" {
  statement {

    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

  }
}

data "aws_iam_policy_document" "consumer-sqs-role-policy" {
  statement {
    sid    = "Logs202008191600"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "SQS202008191600"
    effect = "Allow"

    actions = ["sqs:*"]

    resources = ["*"]
  }
}

data "null_data_source" "consumer-sqs" {
  inputs = {
    version_id = null_resource.consumer-sqs.id
    source_dir = "${path.module}/lambda-functions/consumer-sqs"
  }
}
data "archive_file" "consumer-sqs" {
  type        = "zip"
  source_dir  = data.null_data_source.consumer-sqs.outputs["source_dir"]
  output_path = "${path.module}/lambda-functions/upload/consumer-sqs.zip"
}