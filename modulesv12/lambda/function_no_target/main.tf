resource "aws_lambda_function" "lambda_no_target" {
  vpc_config {
    subnet_ids = "${var.vpc_rds_subnet_ids}"
    # subnet_ids = ["${var.subnet_id_1}", "${var.subnet_id_2}", "${var.subnet_id_3}"]

    security_group_ids = [
      "${var.vpc_rds_security_group_id}",
      "${var.sg_lambda_mysql}",
    ]
  }

  filename         = "${var.file_path}${var.file_name}.zip"
  function_name    = "${var.function_name}"
  role             = "${var.iam_role_arn}"
  handler          = "${var.file_name}.handler"
  source_code_hash = "${base64sha256(file("${var.file_path}${var.file_name}.zip"))}"
  runtime          = "nodejs6.10"
  timeout          = 60

  tags = "${var.tags}"
}

# resource "aws_lambda_permission" "newswirescalendar_permission" {
#   statement_id  = "${var.statement_id}"
#   action        = "${var.action}"
#   function_name = "${var.function_name}"
#   principal     = "events.amazonaws.com"
#   source_arn    = "${var.source_arn}"
# }

output "lambda_arn" {
  value = "${aws_lambda_function.lambda_no_target.arn}"
}

output "function_name" {
  value = "${var.function_name}"
}
