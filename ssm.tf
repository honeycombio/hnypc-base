locals {
  hnypc_base_version = "1"
}

resource "aws_ssm_parameter" "hnypc_base_version" {
  name  = "/hnypc/base/version"
  type  = "String"
  value = local.hnypc_base_version
}
