locals {
  hnypc_base_version = "1"
}

resource "aws_ssm_parameter" "hnypc_base_version" {
  name  = "/hnypc/base/version"
  type  = "String"
  value = local.hnypc_base_version
}

resource "aws_ssm_parameter" "state_bucket_name" {
  name  = "/hnypc/base/state_bucket_name"
  type  = "String"
  value = aws_s3_bucket.terraform_state.id
}
