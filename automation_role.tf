# The hnypc-infra-automation role is used by hnypc-upgrade for bootstrap
# operations (version tracking, release resolution, TF module vendoring).
# The full hnypc-automation role (for app install) is created in env-single-tenant.

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "infra_automation" {
  name               = "${var.hnypc_prefix}-infra-automation"
  assume_role_policy = var.infra_automation_role_trust_policy_json
}

# Cross-account access to hnypc-artifacts releases bucket
data "aws_iam_policy_document" "infra_automation_releases_bucket" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::honeycomb-hnypc-artifacts-releases",
      "arn:aws:s3:::honeycomb-hnypc-artifacts-releases/*",
    ]
  }
}

resource "aws_iam_role_policy" "infra_automation_releases_bucket" {
  role   = aws_iam_role.infra_automation.name
  policy = data.aws_iam_policy_document.infra_automation_releases_bucket.json
}

data "aws_iam_policy_document" "infra_automation_ecr" {
  # GetAuthorizationToken doesn't support resource-level permissions
  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchImportUpstreamImage",
    ]

    resources = concat(
      [for repo in aws_ecr_repository.this : repo.arn],
      [for name in var.additional_infra_automation_ecr_repos :
        "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${name}"
      ],
    )
  }
}

resource "aws_iam_role_policy" "infra_automation_ecr" {
  role   = aws_iam_role.infra_automation.name
  policy = data.aws_iam_policy_document.infra_automation_ecr.json
}

data "aws_iam_policy_document" "infra_automation_version_tracking" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:PutParameter",
      "ssm:DeleteParameter",
    ]
    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.hnypc_prefix}/current-version",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.hnypc_prefix}/active-breakpoint",
    ]
  }
}

resource "aws_iam_role_policy" "infra_automation_version_tracking" {
  role   = aws_iam_role.infra_automation.name
  policy = data.aws_iam_policy_document.infra_automation_version_tracking.json
}

