resource "aws_lambda_layer_version" "efs_directory_creator" {
  s3_bucket = "testasdawf4115154"
  s3_key    = "my_lambda_function.zip"

  layer_name          = "EFSDirectortCreator"
  compatible_runtimes = ["python3.12"]
}

resource "aws_lambda_function" "efs_lambda" {
  function_name    = "efs-directory-creator"
  s3_bucket        = "testasdawf4115154"
  s3_key           = "my_lambda_function.zip"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  role             = aws_iam_role.lambda_iam_role.arn
  layers           = [aws_lambda_layer_version.efs_directory_creator.arn]

  file_system_config {
  arn            = aws_efs_access_point.efs_ap.arn
  local_mount_path = "/mnt/efs"
}
  vpc_config {
    subnet_ids         = [aws_subnet.subnet-1.id]
    security_group_ids = [aws_security_group.efs_sg.id]
  }
depends_on = [aws_efs_mount_target.efs_mount]

   lifecycle {
    create_before_destroy = true
  }

  tags = {
    Environment = "${var.environment}"
  }
}


resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.efs_lambda.function_name
  authorization_type = "NONE"
}

output "lambda_function_url" {
  value = aws_lambda_function_url.lambda_url.function_url
}
