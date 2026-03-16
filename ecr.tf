locals {
  ecr_repos = [
    # Terraform we'll need to bootstrap the instance
    "terraform-modules/infra",
    # Tooling we'll need to bootstrap the instance
    "tenant/upgrade-manager",
    "tenant/hnypc-upgrade",
  ]
}

resource "aws_ecr_repository" "this" {
  for_each = toset(local.ecr_repos)
  name     = each.key

  image_tag_mutability = "MUTABLE"
}

data "aws_iam_policy_document" "ptc_trust_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pullthroughcache.ecr.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "pull_through_cache" {
  name               = "pull-through-cache"
  assume_role_policy = data.aws_iam_policy_document.ptc_trust_policy.json
}

data "aws_iam_policy_document" "pull_through_cache" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:BatchImportUpstreamImage",
      "ecr:BatchGetImage",
      "ecr:GetImageCopyStatus",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "pull_through_cache" {
  role   = aws_iam_role.pull_through_cache.name
  policy = data.aws_iam_policy_document.pull_through_cache.json
}

locals {
  hnypc_artifacts_account_id = "098131747737"
}

resource "aws_ecr_pull_through_cache_rule" "ptc" {
  ecr_repository_prefix = "ROOT"
  upstream_registry_url = "${local.hnypc_artifacts_account_id}.dkr.ecr.us-east-1.amazonaws.com"
  custom_role_arn       = aws_iam_role.pull_through_cache.arn
}

