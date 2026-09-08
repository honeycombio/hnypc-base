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
  # for_each must come from the static repo list, not from aws_ecr_repository.this
  # itself: sourcing for_each from a resource makes its whole instance set look
  # unknown until apply, even though the keys are static, which breaks a
  # from-scratch apply with "Invalid for_each argument".
  for_each = toset(local.ecr_repos)
  name     = "/hnypc/base/ecr/${each.key}/repository_url"
  type     = "String"
  value    = aws_ecr_repository.this[each.key].repository_url
}
