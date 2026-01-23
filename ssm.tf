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

resource "aws_ssm_parameter" "ecr_repository_url" {
  for_each = aws_ecr_repository.this
  name     = "/hnypc/base/ecr/${each.key}/repository_url"
  type     = "String"
  value    = each.value.repository_url
}
