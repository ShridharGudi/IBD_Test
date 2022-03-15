data "aws_subnet_ids" "protected" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "*-pri-*" //search for pri
  }
}

data "aws_vpc" "vpc" {
  tags = {
    Name = var.vpc_name
  }
}

# let me grab the first 3 subnets
data "aws_subnet" "one" {
  id = sort(data.aws_subnet_ids.protected.ids)[0]
}

data "aws_subnet" "two" {
  id = sort(data.aws_subnet_ids.protected.ids)[1]
}

data "aws_subnet" "three" {
  id = sort(data.aws_subnet_ids.protected.ids)[2]
}

data "aws_security_group" "standard" {
  tags = {
    Name = var.sg_standard //search for djin_standard
  }
}

data "aws_security_group" "pam_rds" {
  tags = {
    Name = var.pam_rds
  }
}

data "aws_iam_role" "iam_role" {
  name = var.iam_role_lambda
}

data "template_file" "input_json" {
  template = "{\"identifier\" : \"$${dbname}\",\"db_instance_class\" : \"$${db_instance_class}\",\"db_subnet_group_name\" : \"$${db_subnet_group_name}\"}"
  vars = {
    dbname               = var.identifier
    db_instance_class    = var.instance_class
    db_subnet_group_name = var.db_subnet_group_name
  }
}

module "lambda_restore_snapshot" {
  source = "../../../modulesv12/lambda/function"
  vpc_rds_subnet_ids  = [
    data.aws_subnet.one.id,
    data.aws_subnet.two.id,
    data.aws_subnet.three.id,
  ]
  vpc_rds_security_group_id = data.aws_security_group.standard.id

  #sg_lambda_mysql           = "${data.aws_security_group.sg_lambda_mysql.id}"
  sg_lambda_mysql = data.aws_security_group.standard.id

  file_path     = var.file_path
  file_name     = var.restore_snapshot_lambda_file_name
  function_name = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-lambda"
  iam_role_arn  = data.aws_iam_role.iam_role.arn
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowExecutionFromCloudWatch"

  rule_name                = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  rule_description         = "Snapshot restore in Virginia is disabled by default. It should be enable when require to create DBinstace from snapshot of other region"
  rule_schedule_expression = var.restore_snapshot_time
  target_id                = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  target_input_json        = data.template_file.input_json.rendered
  is_enabled               = var.restore_snapshot_is_enabled

  tags = {
      Name = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-lambda"
      owner = var.owner
      bu = var.bu
      product = var.product
      component = var.component
      environment = var.environment_name
      servicename = var.servicename
      appid       = "in_platform_assets"
  }
}

module "lambda_create_snapshot" {
  source = "../../../modulesv12/lambda/function"

  vpc_rds_subnet_ids  = [
    data.aws_subnet.one.id,
    data.aws_subnet.two.id,
    data.aws_subnet.three.id,
  ]

  vpc_rds_security_group_id = data.aws_security_group.standard.id

  #sg_lambda_mysql           = "${data.aws_security_group.sg_lambda_mysql.id}"
  sg_lambda_mysql = data.aws_security_group.pam_rds.id

  file_path     = var.file_path
  file_name     = var.create_snapshot_lambda_file_name
  function_name = "${var.environment_name}-${var.create_snapshot_lambda_function_name}-${var.site_color}-lambda"
  iam_role_arn  = data.aws_iam_role.iam_role.arn
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowExecutionFromCloudWatch"

  rule_name                = "${var.environment_name}-${var.create_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  rule_description         = "Create snapshot in Virginia is enabled by default. It should be disabled if other region is creating snapshot."
  rule_schedule_expression = var.create_snapshot_time
  target_id                = "${var.environment_name}-${var.create_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  target_input_json        = data.template_file.input_json.rendered
  is_enabled               = var.create_snapshot_is_enabled
  tags = {
      Name = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-lambda"
      owner = var.owner
      bu = var.bu
      product = var.product
      component = var.component
      environment = var.environment_name
      servicename = var.servicename
      appid       = "in_platform_assets"
  }
}

module "lambda_delete_snapshot" {
  source = "../../../modulesv12/lambda/function"

  vpc_rds_subnet_ids  = [
    data.aws_subnet.one.id,
    data.aws_subnet.two.id,
    data.aws_subnet.three.id,
  ]

  vpc_rds_security_group_id = data.aws_security_group.standard.id

  #sg_lambda_mysql           = "${data.aws_security_group.sg_lambda_mysql.id}"
  sg_lambda_mysql = data.aws_security_group.standard.id

  file_path     = var.file_path
  file_name     = var.delete_snapshot_lambda_file_name
  function_name = "${var.environment_name}-${var.delete_snapshot_lambda_function_name}-${var.site_color}-lambda"
  iam_role_arn  = data.aws_iam_role.iam_role.arn
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowExecutionFromCloudWatch"

  rule_name                = "${var.environment_name}-${var.delete_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  rule_description         = "Delete snapshot (every 24 hrs) should be enabled for all regions"
  rule_schedule_expression = var.delete_snapshot_time
  target_id                = "${var.environment_name}-${var.delete_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  target_input_json        = data.template_file.input_json.rendered
  is_enabled               = var.delete_snapshot_is_enabled
  tags = {
      Name = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-lambda"
      owner = var.owner
      bu = var.bu
      product = var.product
      component = var.component
      environment = var.environment_name
      servicename = var.servicename
      appid       = "in_platform_assets"
  }
}

module "lambda_copy_snapshot" {
  source = "../../../modulesv12/lambda/function"

   vpc_rds_subnet_ids  = [
    data.aws_subnet.one.id,
    data.aws_subnet.two.id,
    data.aws_subnet.three.id,
  ]

  vpc_rds_security_group_id = data.aws_security_group.standard.id

  #sg_lambda_mysql           = "${data.aws_security_group.sg_lambda_mysql.id}"
  sg_lambda_mysql = data.aws_security_group.standard.id

  file_path     = var.file_path
  file_name     = var.copy_snapshot_lambda_file_name
  function_name = "${var.environment_name}-${var.copy_snapshot_lambda_function_name}-${var.site_color}-lambda"
  iam_role_arn  = data.aws_iam_role.iam_role.arn
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowExecutionFromCloudWatch"

  rule_name                = "${var.environment_name}-${var.copy_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  rule_description         = "Snapshot copy in Virginia is disabled by default. It should be enable when require to copy DBinstace from snapshot of other region"
  rule_schedule_expression = var.copy_snapshot_time
  target_id                = "${var.environment_name}-${var.copy_snapshot_lambda_function_name}-${var.site_color}-timer-rule"
  target_input_json        = data.template_file.input_json.rendered
  is_enabled               = var.copy_snapshot_is_enabled
   tags = {
      Name = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-lambda"
      owner = var.owner
      bu = var.bu
      product = var.product
      component = var.component
      environment = var.environment_name
      servicename = var.servicename
      appid       = "in_platform_assets"
  }
}

module "lambda_delete_rdsinstance" {
  source = "../../../modulesv12/lambda/function"

  vpc_rds_subnet_ids  = [
    data.aws_subnet.one.id,
    data.aws_subnet.two.id,
    data.aws_subnet.three.id,
  ]

  vpc_rds_security_group_id = data.aws_security_group.standard.id

  #sg_lambda_mysql           = "${data.aws_security_group.sg_lambda_mysql.id}"
  sg_lambda_mysql = data.aws_security_group.standard.id

  file_path     = var.file_path
  file_name     = var.delete_rdsinstance_lambda_file_name
  function_name = "${var.environment_name}-${var.delete_rdsinstance_lambda_file_name}-${var.site_color}-lambda"
  iam_role_arn  = data.aws_iam_role.iam_role.arn
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowExecutionFromCloudWatch"

  rule_name                = "${var.environment_name}-${var.delete_rdsinstance_lambda_function_name}-${var.site_color}-timer-rule"
  rule_description         = "Delete_rdsinstance s disabled by default in Both region. Connect PAM team before enable."
  rule_schedule_expression = var.rdsinstance-delete_time
  target_id                = "${var.environment_name}-${var.delete_rdsinstance_lambda_function_name}-${var.site_color}-timer-rule"
  target_input_json        = data.template_file.input_json.rendered
  is_enabled               = var.rdsinstance-delete_is_enabled
  tags = {
      Name = "${var.environment_name}-${var.restore_snapshot_lambda_function_name}-${var.site_color}-lambda"
      owner = var.owner
      bu = var.bu
      product = var.product
      component = var.component
      environment = var.environment_name
      servicename = var.servicename
      appid       = "in_platform_assets"
  }
}