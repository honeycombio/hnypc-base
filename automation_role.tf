# Create the hnypc-infra-automation role for infra-automation-go to use
# This role only needs S3 access to the releases bucket
# The full hnypc-automation role (for pods) is created in env-single-tenant

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

    resources = [for repo in aws_ecr_repository.this : repo.arn]
  }
}

resource "aws_iam_role_policy" "infra_automation_ecr" {
  role   = aws_iam_role.infra_automation.name
  policy = data.aws_iam_policy_document.infra_automation_ecr.json
}

